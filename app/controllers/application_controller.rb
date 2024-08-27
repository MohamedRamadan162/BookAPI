# frozen_string_literal: true


class ApplicationController < ActionController::API
  include ErrorHandler
  include ResponseHandler
  include Pagy::Backend
  include Pundit::Authorization
  include ActionController::MimeResponds
  include SessionsHelper
  def authenticate_request
    @current_user = AuthorizeApiRequest.new(headers:request.headers).call
  end

  def current_user
    @current_user
  end


  # before_action :validate_session
  # skip_before_action :validate_session, only: %i[create]
  before_action :authenticate_request
  skip_before_action :authenticate_request, only: %i[create forgot_password reset_password]
  # skip_before_action :authenticate_request, only: %i[forgot_password reset_password]
end
