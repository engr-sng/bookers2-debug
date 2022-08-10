class RoomsController < ApplicationController
  before_action :ensure_correct_user, only: [:show]

  def index
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @room_messages = Message.where(room_id: @room.id)

    room_users = RoomEnter.where(user_id: @room.id)

    room_users.each do |room_user|
      if room_user.user_id != current_user.id
        @message_partner = User.find(room_user.user_id)
      end
    end
  end

  def create
    room = Room.new
    room.save

    room_enter1 = RoomEnter.new
    room_enter1.user_id = User.find(current_user.id).id
    room_enter1.room_id = room.id
    room_enter1.save

    room_enter2 = RoomEnter.new
    room_enter2.user_id = User.find(params[:user_id]).id
    room_enter2.room_id = room.id
    room_enter2.save

    redirect_to room_path(room.id)
  end

  def ensure_correct_user
    room = Room.find(params[:id])
    room_user = RoomEnter.find_by(room_id: room.id, user_id: current_user.id)
    if room_user.nil?
      redirect_to user_path(current_user)
    end
  end
end
