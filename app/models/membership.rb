class Membership < ActiveRecord::Base
  belongs_to :user, include[:profile]
  belongs_to :group
end
