class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def user_index
    @groups = Group.where(inviter_ids: current_user.id)
  end

  def show
    @group = Group.find(params[:id])
    @users = User.where(id: @group.invited_ids.split(',').map{ |elem| elem.to_i })
  end

  def new
    @group = Group.new(inviter_ids: [current_user.id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    inv_ids = (params[:group][:invited_ids])
    @group = Group.find(params[:id])
    hash = { invited_ids: inv_ids }
    hash.merge(group_params)
    if @group.update(hash)
      redirect_to groups_path, notice: 'Group Updated'
    else
      render :edit
    end
  end

  def create
    inv_ids = (params[:group][:invited_ids])
    @group = Group.new(group_params)
    if @group.save
      @group.update(invited_ids: inv_ids)
      redirect_to groups_path, notice: 'Group created.'
    else
      redirect_to groups_path, alert: "Something went wrong."
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      redirect_to groups_path, notice: "Group deleted"
    else
      redirect_to groups_path, alert: "Something went wrong"
    end
  end

  private

  def group_params
    params.require(:group).permit(:id, :title, :inviter_ids, :invited_ids)
  end
end
