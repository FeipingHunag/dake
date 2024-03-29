class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :token_authenticatable

  before_create :ensure_authentication_token

  has_one  :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  delegate :name, :bio, :gender, :dob, :age, :zodiac_sign, to: :profile
  mount_uploader :avatar, AvatarUploader

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                     dependent: :destroy

  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :memberships, dependent: :destroy

  has_many :groups, through: :memberships, source: :group do
    def create *params, &block
      Membership.with_scope(create: {role: 'owner'}) {super}
    end
  end

  has_many :conversations
  has_many :received_messages_relation, as: :received_messageable
  has_many :photos, dependent: :destroy
  has_many :locations, dependent: :destroy

  before_create :generate_profile

  define_index do
    indexes plate_number, :sortable => true

    set_property :delta => true
  end

  def serializable_hash options = nil
    options ||= {}
    super(options.merge(force_except: Devise::Models::Authenticatable::BLACKLIST_FOR_SERIALIZATION.delete_if{|x| x == :authentication_token}))
  end

  def following?(other_user)
    relationships.where(followed_id: other_user.id).exists?
  end

  def followed_by?(other_user)
    reverse_relationships.where(follower_id: other_user.id).exists?
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.followed_id).destroy
  end

  def followers_count
    @followers_count ||= self.reverse_relationships.count
  end

  def followed_users_count
    @followed_users_count ||= self.relationships.count
  end

  def member?(group)
    memberships.find_by_group_id(group).exists?
  end

  def join_group!(group)
    memberships.create!(group_id: group.id)
  end

  def leave_group!(group)
    memberships.find_by_group_id(group).destroy
  end

  def groups_count
    @groups_count ||= self.memberships.count
  end

  def send_message_to(to, message_attributes)
    Message.create(message_attributes) do |m|
      m.received_messageable = to
      m.user = self
    end
  end

  def delete_message(message)
    case self
      when message.to
        attribute = :recipient_delete
      when message.from
        attribute = :sender_delete
      else
        raise "#{self} can't delete this message"
    end

    message.update_attributes!(attribute => true)
  end

  def nearby(longitude, latitude)
    users = User.select("users.*, t.distance, t.created_at as located_at").joins("right join (select ul1.*, st_distance(st_point(#{longitude}, #{latitude}), ul1.coordinate, false) distance from uniq_locations ul1 where not exists
    (select 1 from uniq_locations ul2
    where ul1.user_id = ul2.user_id
    and st_distance(st_point(#{longitude}, #{latitude}), ul2.coordinate, false) < st_distance(st_point(#{longitude}, #{latitude}), ul1.coordinate, false)) and ul1.user_id != #{self.id}) t on t.user_id = users.id").order("t.distance")
  end

  protected
    def generate_profile
      self.build_profile(dob: Time.now) if self.profile.nil?
    end
end
