class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    follow = Relationship.new
    follow.follower_id = current_user.id
    follow.followed_id = user.id
    follow.save
    redirect_back fallback_location: users_path
  end

  def destroy
    user = User.find(params[:user_id])
    follow = Relationship.find_by(follower_id: current_user.id, followed_id: user.id)
    follow.destroy
    redirect_back fallback_location: users_path
  end

  def following
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def follower
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
