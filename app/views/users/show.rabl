object @user
extends 'users/base'
node(:is_follow) { |user| user.followed_by? current_user}

attributes :followers_count, :followed_users_count, :groups_count, :created_at
