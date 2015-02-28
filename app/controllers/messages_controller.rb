class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_room_permission, only: [:index, :create]
  def index
    respond_to do |format|
      format.json do
        messages = room.messages
        render json: messages
      end
    end
  end

  def create
    respond_to do |format|
      format.json do 
        recipient = if (@room.first_user == current_user)
          @room.second_user
        else
          @room.first_user
        end
        message = @room.messages.create(create_params.merge(sender: current_user, recipient: recipient))
        render json: message
      end
    end
  end

  def update
    respond_to do |format|
      format.json do 
        message = Message.where(id: params[:id])
        verify_room_permission message.room_id
        message.update_attributes(update_params)
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do 
        message = Message.where(id: params[:id])
        verify_room_permission message.room_id
        message.destroy    
      end
    end
  end

  private
  def create_params
    params.require(:message).permit(:body)
  end
  def update_params
    create_params
  end

  def verify_room_permission room_id
    if room_id||params[:room_id]
      room = Room.where(room_id: room_id||params[:room_id]).first
      if room
        if room.first_user_id == current_user.id || room.second_user_id == current_user.id
          @room = room
        else
          render nothing: true, status: :unauthorized and return
        end
      else
        render nothing: true, status: :not_found and return
      end
    else
      render nothing: true, status: :bad_request and return
    end
  end

end