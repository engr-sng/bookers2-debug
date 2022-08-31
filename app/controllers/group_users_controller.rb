class GroupUsersController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @group_user_new = GroupUser.new
    @group_user_new.group_id = @group.id
    @group_user_new.user_id = current_user.id
    @group_user_new.save
    redirect_to groups_path
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.find_by(group_id: @group.id, user_id: current_user.id)
    @group_user.destroy
    redirect_to groups_path
  end
end
