class Message < ActiveRecord::Base
  #mtype 0:text, 1:photo, 2:audio
  MESSAGE_TYPE = {text: 0, photo: 1, audio: 2}
  belongs_to :user
  belongs_to :received_messageable, :polymorphic => true

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
    message_type = self.mtype
    case message_type
      when MESSAGE_TYPE.text then return
      when MESSAGE_TYPE.photo 
        uploaderClass =  PhotoUploader
      when MESSAGE_TYPE.audio 
        uploaderClass = AudioUploader
      else 
        raise "unknow message_type #{message_type}"
    end
    uploader = uploaderClass.new
    uploader.store!(self.content)
    self.content = uploader.url
  end
end
