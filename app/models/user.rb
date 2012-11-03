class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :lockable,:token_authenticatable

  has_one  :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile


  before_create :generate_profile


  protected
  def generate_profile
    self.build_profile(dob: Time.now) if self.profile.nil?
  end
end
