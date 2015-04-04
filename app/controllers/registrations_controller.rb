class RegistrationsController < Devise::RegistrationsController  
  clear_respond_to
  respond_to :json
  skip_before_action :check_user
  before_filter :configure_permitted_parameters

  

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :current_password)
    end
  end
end