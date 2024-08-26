class AuthorizeApiRequest
  def initialize(**args)
  # receive parameters
  @headers = args[:headers]
  end
  def call
    user = User.find(decoded_auth_token['user_id'])
    if user.devices_tokens.where(device_id: decoded_auth_token['device_id']).empty?
      raise(ErrorHandler::AuthenticationError, 'invalid credentials')
    end
    user
  end

  def auth_token
    return @headers['Authorization'].split.last if
    @headers['Authorization'].present?
    raise(ErrorHandler::MissingToken, 'Missing Token')
  end

  def decoded_auth_token
    JWT.decode(auth_token, Constants::JWT_SECRET)[0]
  end
  end