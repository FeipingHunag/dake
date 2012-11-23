class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :received_messageable, polymorphic: true
  has_enumeration_for :mtype, with: MessageType,
                              create_scopes: true,
                              create_helpers: true,
                              required: true

  default_scope order("created_at desc")

  scope :connected_with, ->(u1, u2) {
    where{((user_id == u1.id) & (received_messageable_type == 'User') &
           (received_messageable_id == u2.id) & (sender_delete == false)) |
          ((user_id == u2.id) & (received_messageable_type == 'User') &
           (received_messageable_id == u1.id) & (recipient_delete == false))}
  }

  scope :readed,  -> { where(opened: true)  }
  scope :unreaded,  -> { where(opened: false) }

  before_create :process_content
  after_create :update_conversation, if: :user_received?
  after_create :async_pusher

  alias :from :user
  alias :to   :received_messageable

  def mark_as_read
    self.update_attributes!(opened: false)
    Conversation.connected_with(self.user_id, self.received_messageable_id).decrement!(:unread_count)
  end

  def timestap
    self.created_at.to_i
  end

  def user_received?
    self.received_messageable_type == 'User'
  end

  private
  def process_content
    return if self.text?
    uploader = "#{self.mtype_humanize}Uploader".constantize.new
    uploader.store!(self.content)
    self.content = uploader.url
  end

  def update_conversation
    friend_user = Conversation.connected_with(self.received_messageable_id, self.user_id).first_or_create
    friend_user.update_attributes(
      messages_count: friend_user.messages_count + 1,
      unread_count: friend_user.unread_count + 1,
      last_message_id: self.id
    )

    user_friend = Conversation.connected_with(self.user_id, self.received_messageable_id).first_or_create
    user_friend.update_attributes(
      messages_count: user_friend.messages_count + 1,
      last_message_id: self.id
    )
  end

  def async_pusher
    if user_received?
      push_message(to.id)
    else
      (to.member_ids - self.user_id).each{|user| push_message(user.id)}
    end
  end

  def push_message(received_id)
    SocketPusher[received_id.to_s].trigger('msg_created', self.serializable_hash)
  end
end
