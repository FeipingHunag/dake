class HomeController < ApplicationController
  def index
    # binding.pry
    @groups = current_user.groups
    @following = current_user.followed_users
    @followers = current_user.followers
  end
end
