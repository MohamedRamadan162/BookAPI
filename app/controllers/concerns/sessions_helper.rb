module SessionsHelper
  extend ActiveSupport::Concern
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if
    session[:user_id]
  end

    def validate_session
      raise(ErrorHandler::MissingSession, 'No session found! Please log in')
      if session[:user_id].nil?
    end
  end

    def log_out
      reset_session
      @current_user = nil
  end
end