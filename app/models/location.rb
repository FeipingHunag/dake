class Location < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
end
