class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :check_user, except: :cors_preflight_check
  after_filter :set_access_control_headers
  respond_to :json

  # respond to options requests with blank text/plain as per spec
  def cors_preflight_check
    logger.info ">>> responding to CORS request"
    render :text => '', :content_type => 'text/plain'
  end

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = '*' 
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*' 
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-CSRF-Token, X-API-EMAIL, X-API-TOKEN'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  protected
  def check_user
    email = request.headers['X-API-EMAIL']
    token = request.headers['X-API-TOKEN']
    @user = User.where(email: email).first
    if @user && Devise.secure_compare(@user.authentication_token, token)
      sign_in(@user, store: false)
    else
      render nothing: true, status: :unauthorized
    end
  end
end
