class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    respond_to do |format|
      format.json do 
        min_birthday = Date.today.year - current_user.max_age
        max_birthday = Date.today.year - current_user.min_age
        users = current_user.around.where(gender: current_user.gender_preference).where("birthday < ? AND birthday > ?", max_birthday, min_birthday)
        render json: users, each_serializer: ShortUserSerializer
      end
    end
  end
end