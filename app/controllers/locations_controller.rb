class LocationsController < ApplicationController
  respond_to :json
  
  def create
    coordinate = RGeo::Geos.factory.point(params[:longitude], params[:latitude])
    current_user.locations.create(:coordinate => coordinate)
  end
  
  def nearby
    coordinate = RGeo::Geos.factory.point(params[:longitude].to_f, params[:latitude].to_f)
    current_user.locations.create(:coordinate => coordinate)
    @users = current_user.nearby(params[:longitude], params[:latitude]).includes(:profile)
    respond_with @users
  end
end
