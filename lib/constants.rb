# frozen_string_literal: true

# app/lib/constants.rb
module Constants
  AR_NUMBERS = '٠١٢٣٤٥٦٧٨٩'
  EN_NUMBERS = '0123456789'
  MAX_NUMBER_OF_RESET_PASSWORD_TRIES = 3
  MAX_NUMBER_OF_RESEND_VERIFICATION_TRIES = 3

  TMP_PASSWORD = 'Template_123'

  JWT_SECRET = 'my-ultra-secure-secret'

  FORGOT_PASSWORD_EXPIRY_DURATION = 5.minutes

  TIME_FORMAT = /\A([0-1]?[0-9]|2[0-3]):[0-5][0-9]\z/.freeze
  PASSWORD_FORMAT = /\A.*(?=.{8,})(?=.*\d)(?=.*[a-z]).*\z/.freeze
  EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/.freeze
  DATETIME_FORMAT = /\A([0-9]{4})-?(1[0-2]|0[1-9])-?(3[01]|0[1-9]|[12][0-9]) \d{1,2}:\d{1,2}\Z/.freeze
end
