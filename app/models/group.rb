class Group < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user
  has_many :message_recipients, as: :message_recipientable
  has_many :messages, through: :message_recipients, source: :message
end
