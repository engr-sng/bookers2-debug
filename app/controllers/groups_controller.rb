class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group_new = Group.new
  end

  def create
    @group_new = Group.new(group_params)
    @group_new.user_id = current_user.id
    if @group_new.save
      group_user_new = GroupUser.new
      group_user_new.group_id = @group_new.id
      group_user_new.user_id = @group_new.user_id
      group_user_new.save
      redirect_to groups_path
      flash[:notice] = "グループを作成しました。"
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
      flash[:notice] = "グループを編集しました。"
    else
      render :edit
    end

  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.user_id == current_user.id
      redirect_to groups_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end
end
