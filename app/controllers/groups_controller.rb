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

  def join
    current_user.join_group! @groups
    head status: 200
  end

  def leave
    current_user.leave_group! @groups
    head status: 204
  end

  protected
  def get_group
    @group = Group.find_by_id params[:id]
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
