class EntitiesController < ApplicationController
  before_action :set_group

  def new
    @entity = Entity.new
  end

  def create
    entity = Entity.create(entity_params)
    entity.author = current_user
    group = current_user.groups.find(params[:group_id]) if params[:group_id].present?

    if entity.save
      group.entities << entity

      redirect_to group_path(group), notice: 'Entity created successfully'
    else
      render new_entity_path, alert: entity.errors.full_messages.join(', ')
    end
  end

  private

  def set_group
    @groups = current_user.groups
    @group = current_user.groups.find(params[:group_id])
  end

  def entity_params
    params.require(:entity).permit(:name, :amount)
  end
end
