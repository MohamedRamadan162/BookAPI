class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render_success(user: user)
  end

  skip_before_action :authenticate_request, only: %i[forgot_password]
  def forgot_password
    User.find_by_email(params[:email]).forgot_password
    render_success(message: 'Forgot password email sent')
  end

  def reset_password
    user = User.find_by_email(params[:email])
    user.reset_password(params.permit(:forgot_password_code, :password))
    render_success(message: 'Password reset successfully')
  end
end
