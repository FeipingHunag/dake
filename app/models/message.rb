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

  alias :from :user
  alias :to   :received_messageable

  def mark_as_read
    self.update_attributes!(opened: false)
  end

  private
  def process_content
    return if self.text?
    uploader = "#{self.mtype_humanize}Uploader".constantize.new
    uploader.store!(self.content)
    self.content = uploader.url
  end
end
