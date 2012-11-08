# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  self.upyun_bucket = "dake-avatars"
  self.upyun_bucket_domain = "dake-avatars.b0.upaiyun.com"
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  def filename
    @name ||= "#{secure_token}.#{file.extension.downcase}" if original_filename.present?
  end
  
  protected
    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    end
end
