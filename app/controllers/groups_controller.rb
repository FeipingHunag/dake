class GroupsController < ApplicationController
  before_filter :get_group, except: [:create]

  def index
    @groups = current_user.groups
  end

  def create
    if @group = current_user.groups.create(group_params)
      render :show, status: 201
    else
      invalid_resource! @group
    end
  end

  def show

  end

  def messages
    @messages = @group.messages
  end

  def join
    current_user.join_group! @groups
    head status: 200
  end

  def leave
    current_user.leave_group! @groups
    head status: 204
  end
  
  def search
    params[:q] = params[:q].gsub(/[^\u4E00-\u9FA5\w\s]/,'')
    if params[:q].present?
      @groups = Group.search(params[:q],:sort_mode => :extended,:order => "@weight DESC", :page => 1, :per_page => 20)
    end
  end

  protected
  def get_group
    @group = Group.find_by_id params[:id]
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
