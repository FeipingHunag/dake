class Photo < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  mount_uploader :image, PhotoUploader
  belongs_to :user
end
