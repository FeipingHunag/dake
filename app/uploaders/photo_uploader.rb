class PhotoUploader < CarrierWave::Uploader::Base
  self.upyun_bucket = "dake-photos"
  self.upyun_bucket_domain = "dake-photos.b0.upaiyun.com"
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  def filename
    @name ||= "#{SecureRandom.hex(8)}.#{file.extension.downcase}" if original_filename.present?
  end
end
