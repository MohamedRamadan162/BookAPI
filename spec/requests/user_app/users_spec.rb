# frozen_string_literal: true

require 'swagger_helper'
RSpec.describe 'user_app/v1/users_controller', type: :request do
  path '/user_app/v1/users' do
    post 'User classical registration' do
      tags 'User App / Users'
      description "This API is responsible for:\n
      * Creating a user with phone number or email  and password only\n
      * Sending an sms to the user to verify their phone number or email\n
      * Throwing an error if this phone number or email is already registered and verified"

      operationId 'UserClassicRegistration'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          phone_number: { type: :string, example: '1225533224' },
          dial_code: { type: :string, example: '+20' },
          country_id: { type: :integer, example: 63 },
          password: { type: :string, example: 'Template_123' },
          device_id: { type: :string, example: 'nddkwmsndj' },
          fcm_token: { type: :string, example: '84y7uidhu2h394hdu2hdihoejdiu2' }
        },
        required: %w[email phone_number password device_id]
      }

      response 201, 'User created successfully' do
        response_ref 'UserApp/User/Show'
        run_test!
      end
    end
  end
end
