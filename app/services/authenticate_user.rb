class AuthenticateUser
  def initialize(**args)
    @email = args[:email]
    @password = args[:password]
    @device_id = args[:device_id]
  end

  def call
    user = fetch_user
    token = JWT.encode({ user_id: user.id, device_id: @device_id, exp: 24.hours.from_now.to_i }, Constants::JWT_SECRET)
    [user, token]
  end

  def fetch_user
    user = User.find_by_email(@email)
    return user if user.present? && user.authenticate(@password)
    raise_invalid_credentials
  end

  def raise_invalid_credentials
    raise(ErrorHandler::AuthenticationError, 'invalid credentials')
  end
end