class PhotosController < ApplicationController
  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      render json: {url: @photo.image_url, id: @photo.id}
    else
      render josn: {rc: 0}
    end
  end

  def destory
    @photo = current_user.photos.find(params[:id])
    @photo.destory
    render nothing: true
  end

  private
    def photo_params
      params.require(:photo).permit(:image)
    end
end
