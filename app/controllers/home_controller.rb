class HomeController < ApplicationController
  def index
    @groups = current_user.groups
    @following = current_user.followed_users
    @followers = current_user.followers
  end
end
