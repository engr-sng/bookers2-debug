class MessagesController < ApplicationController
  def create
    room = Room.find(params[:room_id])
    message = Message.new(message_params)
    message.room_id = room.id
    message.user_id = current_user.id
    message.save

    redirect_back fallback_location: users_path
  end

  private
    def message_params
      params.require(:message).permit(:message)
    end
end
