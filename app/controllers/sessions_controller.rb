class SessionsController < ApplicationController
  before_action :find_user, only: %i[create]

  def create
    # SESSION-BASED AUTHENTICATION

    # authenticate_user
    # reset_session
    # log_in @user
    # render_success(user: @user)

    # TOKEN-BASED AUTHENTICATION
    user, token = AuthenticateUser.new(email: params[:email], password: params[:password], device_id: params[:device_id]).call
    user.devices_tokens.find_or_create_by!(device_id: params[:device_id])
    render_success(token: token)
  end

  def destroy
  # SESSION-BASED AUTHENTICATION

    # log_out
    # render_success(message: 'User logged out successfully')

    # TOKEN-BASED AUTHENTICATION
    @current_user.devices_tokens.find_by(device_id: fetch_from_jwt('device_id')).destroy!
    render_success(message: 'Logged out successfully')
  end

  def fetch_from_jwt(key)
    JWT.decode(request.headers['Authorization'].split.last, Constants::JWT_SECRET)[0][key]
  end

  private
  def find_user
    @user = User.find_by!(email: params[:email])
  end
  def authenticate_user
    raise(ErrorHandler::AuthenticationError, 'Incorrect Password') unless @user.authenticate(params[:password])
  end
 
end