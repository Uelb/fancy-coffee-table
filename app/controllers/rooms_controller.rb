class RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    respond_to do |format|
      format.json do
        if current_user.id == params[:user_id]
          rooms = current_user.active_rooms
          render json: rooms
        else
          render nothing: true, status: :unauthorized
        end
      end
    end
  end

  def show
    room = Room.find params[:id]
    if room.first_user == current_user || room.second_user == current_user
      render json: room
    else
      render nothing: true, status: :forbidden
    end
  end
  
  def create
    # This is the most difficult part, we need to find someone at the moment the
    # request is done or to make the user wait for someone available. We should
    # probably implement a queue and use websocket to connect the user to the room
    # and for subsequent calls
    if room = Room.where(second_user_id: nil).first
      room.second_user = current_user
      # Send the id of the common room
      room.save!
      WebsocketRails[room.channel_name].trigger "new_second_user", room.second_user_id
    else
      room = current_user.rooms_as_first_user.create!(create_params)
    end
    render json: room
  end

  def update
    respond_to do |format|
      format.json do 
        room = Room.where(id: params[:user_id]).first
        if room.first_user_id == current_user.id
          room.first_user_profile_displayed = true
          room.save
          render json: room
        elsif room.second_user_id == current_user.id
          room.second_user_profile_displayed = true
          room.save
          render json: room
        else
          render nothing: true, status: :bad_request
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        room = Room.where(id: params[:user_id]).first
        if room.first_user_id == current_user.id
          room.displayed_for_first_user = false
          room.save
          render nothing: true
        elsif room.second_user_id == current_user.id
          room.displayed_for_second_user = false
          room.save
          render nothing: true
        else
          render nothing: true, status: :bad_request
        end
      end
    end
  end

  private
  def create_params
    params.require(:room).permit(:latitude, :longitude)
  end
end