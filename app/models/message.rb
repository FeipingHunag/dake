class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :received_messageable, :polymorphic => true

  default_scope order("created_at desc")

  scope :connected_with, ->(u1, u2) {
    where{((user_id == u1.id) & (received_messageable_type == 'User') & (received_messageable_id == u2.id)) |
          ((user_id == u2.id) & (received_messageable_type == 'User') & (received_messageable_id == u1.id))}
  }

  scope :readed,  -> { where(opened: true)  }
  scope :unreaded,  -> { where(opened: false) }

  def mark_as_read
    self.update_attributes!(opened: false)
  end
end
