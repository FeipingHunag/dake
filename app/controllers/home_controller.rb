class HomeController < ApplicationController
  def index
    @groups = current_user.groups
    @following = current_user.followed_users
    @followers = current_user.followers

    @ids = current_user.group_ids << current_user.id
  end
end
