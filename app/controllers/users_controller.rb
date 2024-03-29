class UsersController < ApplicationController
  before_filter :get_user, except: [:update_profile, :search]

  def show
  end

  def following
    @users = @user.followed_users
    render 'follow'
  end

  def followers
    @users = @user.followers
    render 'follow'
  end

  def follow
    rc = 0
    unless current_user.following? @user
      rc = 1 if current_user.follow! @user
    end
    render json: {rc: rc}
  end

  def unfollow
    rc = 0
    if current_user.following? @user
      rc = 1 if current_user.unfollow! @user
    end
    render json: {rc: rc}
  end

  def update_profile
    @user = current_user
    if @user.update_without_password(params[:user])
      sign_in :user, current_user, bypass: true
      render :show, status: 200
    else
      invalid_resource! @user
    end
  end

  def update_password
    @user = current_user
    if @user.update_with_password(params[:user])
      sign_in :user, current_user, bypass: true
      head status: 200
    else
      invalid_resource! @user
    end
  end

  def update_avatar
    @user = current_user
    if @user.update_without_password(params[:user])

    else
      invalid_resource! @user
    end
  end
  
  def search
    params[:q] = params[:q].gsub(/[^\u4E00-\u9FA5\w\s]/,'')
    if params[:q].present?
      @users = User.search(params[:q],:sort_mode => :extended,:order => "@weight DESC", :page => 1, :per_page => 20)
      render "search.rabl"
    end
  end

  protected
  def get_user
    @user = User.find params[:id]
  end
end
