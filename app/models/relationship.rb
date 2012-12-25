class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User", include: [:profile]
  belongs_to :followed, class_name: "User", include: [:profile]

  validates :follower_id, :followed_id, presence: true
end
