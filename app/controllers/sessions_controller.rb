class SessionsController < Devise::SessionsController
  clear_respond_to
  respond_to :json
  skip_before_action :check_user
end  