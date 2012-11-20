attributes :id, :nickname, :bio, :avatar_url
node(:is_follow) { |user| user.followed_by? current_user}