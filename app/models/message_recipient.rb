class MessageRecipient < ActiveRecord::Base
  belongs_to :message
  belongs_to :message_recipientable, polymorphic: true
end
