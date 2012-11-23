class Conversation < ActiveRecord::Base
  self.primary_key = :id

  belongs_to :user,   :class_name => "User", :foreign_key => "user_id"
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"
  belongs_to :last_message, :class_name => "Message", :foreign_key => "last_message_id"

  # attr_accessible :user_id, :friend_id, :messages_count, :unread_count, :last_message_id

  scope :not_blank, where("messages_count > 0")
  scope :connected_with, ->(user_id, friend_id) {
    where(user_id: user_id, friend_id: friend_id)
  }

end
