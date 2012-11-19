class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :lockable,:token_authenticatable

  before_create :ensure_authentication_token
  
  has_one  :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

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
  has_many :received_messages_relation, as: :received_messageable
  has_many :photos, dependent: :destroy

  before_create :generate_profile

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
    @followers_count ||= self.follower_relationships.count
  end

  def followed_users_count
    @followed_users_count ||= self.reverse_relationships.count
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

  def send_message_to(to, message_attributes)
    Message.create(message_attributes) do |m|
      m.received_messageable = to
      m.user = self
    end
  end

# Mark message as deleted
  def delete_message(message)
    current_user = self

    case current_user
      when message.to
        attribute = :recipient_delete
      when message.from
        attribute = :sender_delete
      else
        raise "#{current_user} can't delete this message"
    end

    message.update_attributes!(attribute => true)
  end

  protected
  def generate_profile
    self.build_profile(dob: Time.now) if self.profile.nil?
  end
end
