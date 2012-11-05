class Relationship < ActiveRecord::Base
  belongs to :follower, class name: "User"
  belongs to :followed, class name: "User"

  validates :follower_id, :followed_id, presence: true
end
