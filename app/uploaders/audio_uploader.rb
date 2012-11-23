class AudioUploader < CarrierWave::Uploader::Base
  self.upyun_bucket = "dake-audios"
  self.upyun_bucket_domain = "dake-audios.b0.upaiyun.com"
  
  def filename
    @name ||= "#{SecureRandom.hex(8)}.#{file.extension.downcase}" if original_filename.present?
  end
end
