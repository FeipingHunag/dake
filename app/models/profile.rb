class Profile < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  belongs_to :user

  zodiac_reader :dob

  before_save :calc_age, :if => Proc.new {|profile| profile.dob_changed?}

  private
  def calc_age
    now = Time.now.utc.to_date
    self.age = now.year - dob.year - (dob.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end
