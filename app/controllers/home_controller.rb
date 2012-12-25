class HomeController < ApplicationController
  def index
    @ids = current_user.group_ids << current_user.id
    render json: @ids.map(&:to_s)
  end
end
