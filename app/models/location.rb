class Location < ActiveRecord::Base
  
  belongs_to :user
  attr_accessible :coordinate, :user_id
end
