class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  def average
    respond_to do |format|
      format.json do 
        score = Evaluation.where(reviewed_user_id: params[:user_id]).average(:score)
        render json: score
      end
    end
  end
  def index
    respond_to do |format|
      format.json do 
        evaluations = User.where(id: params[:user_id]).first.received_evaluations
        render json: evaluations
      end
    end
  end
  def create
    respond_to do |format|
      format.json do 
        if Room.exists(first_user_id: current_user.id, second_user_id: params[:user_id]) ||
          Room.exists(second_user_id: current_user.id, first_user_id: params[:user_id])
          reviewed_user = User.where(id: params[:user_id]).first
          if reviewed_user
            Evaluation.create(reviewer: current_user, reviewed_user: reviewed_user)
          else
            render nothing: true, status: :not_found
          end
        else
          render nothing: true, status: :unauthorized
        end
      end
    end
  end
end