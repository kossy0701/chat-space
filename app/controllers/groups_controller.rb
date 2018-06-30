class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

  def index
     @message = Message.new
     @group = current_user.groups
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'Successed to create groups'
    else
      redirect_to new_group_path, notice: "Could you please input group name?"
    end
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: 'Successed to edit group'
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, {user_ids:[]})
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
