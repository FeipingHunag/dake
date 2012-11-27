collection @followers

extends 'users/base'
node(:is_follow) { |user| user.followed_by? current_user}