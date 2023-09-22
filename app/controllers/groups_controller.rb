class GroupsController < ApplicationController
  before_action :set_group, only: [:show]

  def index
    @groups = current_user.groups
  end

  def show; end

  def new
    @group = Group.new
  end

  def create
    group = Group.create(group_params)
    group.author = current_user

    if group.save
      redirect_to group_path(group), notice: 'Group created successfully'
    else
      render new_group_path, alert: group.errors.full_messages.join(', ')
    end
  end

  private

  def set_group
    @group = Group.find_by(id: params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
