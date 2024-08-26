# frozen_string_literal: true

require 'rails_helper'

def example_file(path)
  path = "#{path}.json" unless path.ends_with? '.json'
  full_path = "doc/responses/#{path}"
  examples 'application/json' => JSON.parse(File.read(full_path)) if File.exist? full_path
end

def global_concepts_ref(reference)
  parameter '$ref' => "#/components/global_concepts/#{reference}"
end

def schema_ref(reference)
  schema '$ref' => "#/components/schemas/#{reference}"
end

def response_ref(reference)
  schema '$ref' => "#/components/responses/#{reference}"
end

def model_schema(properties = {}, required = [])
  {
    type: 'object',
    required: required,
    properties: properties
  }
end

def model_ref(ref, is_array: false, nullable: false)
  o = is_array ? { type: :array, items: { '$ref' => "#/components/schemas/#{ref}" } } : { '$ref' => "#/components/schemas/#{ref}" }
  o[:nullable] = true if nullable
  o
end

def response_model_schema_ref(ref, data_key, lookups_type: nil, is_array: false)
  response = {
    type: 'object',
    required: %w[success data],
    properties: {
      success: { type: :boolean, example: true },
      message: { type: :string, description: 'response message' }
    }
  }
  response[:properties][:type] = { type: :string, example: lookups_type, description: 'Type of data returned in case of lookups' } if lookups_type.present?
  response[:properties][data_key.to_s] =
    is_array ? { type: :array, items: { '$ref' => "#/components/schemas/#{ref}" } } : { '$ref' => "#/components/schemas/#{ref}" }
  response
end

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Template API',
        description: 'Template API documentation',
        version: 'v1'
      },
      paths: {},
      servers: [
        # TODO: Add staging URL
        { url: 'http://localhost:3000/api', description: 'Local Development' }
      ],
      components: {
        securitySchemes: {
          user_auth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: :JWT
          }
        },
        global_concepts: {
          id_param: {
            name: 'id',
            in: :path,
            description: 'The id to fetch with',
            required: true,
            schema: {
              type: :number,
              example: 1
            }
          },
          locale_param: {
            name: 'locale',
            in: 'query',
            type: 'string',
            description: "A localiztion param and it only accepts **ar** or **en**. \n
             > Please note: in case of passing this param in any protected endpoint
             it automatically overrides the locale of the current user",
            required: false,
            schema: {
              type: 'string',
              example: 'ar',
              default: 'en'
            }
          },
          page_param: {
            name: 'page',
            in: :query,
            description: 'The current page for paginated items, send it with value = -1 if no pagination needed',
            schema: {
              type: :number,
              example: 3
            }
          },
          items_param: {
            name: 'items',
            in: :query,
            description: 'The number of items per page',
            schema: {
              type: :number,
              example: 10
            }
          }
        },
        schemas: {
          User: model_schema(
            {
              id: { type: :integer, example: 1, readOnly: true },
              email: { type: :string, example: 'example@example' },
              first_name: { type: :string, example: 'fname' },
              last_name: { type: :string, example: 'kname' },
              image: { type: :string, example: 'www.images.com/image.png' },
              is_notifiable: { type: :boolean, example: true },
              phone_number: { type: :string, example: '96655' },
              status: { type: :string, enum: %w[unblocked blocked], example: 'unblocked' },
              deleted_at: { type: :date_time, example: '2021-08-31T10:16:26.551Z' },
              country: model_ref('Country'),
              is_classical: { type: :boolean, example: true },
              is_phone_verified: { type: :boolean, example: true },
              is_email_verified: { type: :boolean, example: false }
            },
            %i[id email first_name last_name]
          ),
          DetailedUser: model_schema(
            {
              id: { type: :integer, example: 1, readOnly: true },
              email: { type: :string, example: 'example@example' },
              first_name: { type: :string, example: 'fname' },
              last_name: { type: :string, example: 'kname' },
              image: { type: :string, example: 'www.images.com/image.png' },
              is_notifiable: { type: :boolean, example: true },
              phone_number: { type: :string, example: '96655' },
              gender: { type: :string, enum: %w[male female], example: 'male' },
              status: { type: :string, enum: %w[unblocked blocked], example: 'unblocked' },
              deleted_at: { type: :date_time, example: '2021-08-31T10:16:26.551Z' },
              must_change_password: { type: :boolean, example: false,
                                      description: "true if a temp password sent to user so password must be changed,
                              false if password is user's primary password" },
              country: model_ref('Country'),
              is_classical: { type: :boolean, example: true },
              is_phone_verified: { type: :boolean, example: true },
              is_email_verified: { type: :boolean, example: false },
              date_of_birth: { type: :date_time, example: '2000-07-18 12:00' },
              can_resend_sms: { type: :boolean, example: true }
            },
            %i[id email first_name last_name]
          ),
          Notification: model_schema(
            id: { type: :integer, example: 1 },
            is_seen: { type: :boolean, example: true },
            created_at: { type: :datetime, example: '2023-02-06T12:38:03.081+03:00' },
            title: { type: :string, example: 'title' },
            body: { type: :string, example: 'body' },
            click_action: { type: :string, enum: %w[], example: '' },
            action_id: { type: :string, example: '5' },
            icon: { type: :string, enum: %w[announcement update], example: 'announcement' }
          ),
          Country: model_schema(
            {
              id: { type: :integer, example: 63 },
              name_ar: { type: :string, example: 'مصر' },
              name_en: { type: :string, example: 'Egypt' },
              dial_code: { type: :string, example: '+20' },
              short_code: { type: :string, example: 'EG' }
            },
            %i[id name_en name_ar]
          ),
          Lookup: model_schema(
            {
              country: { type: :array, items: {
                type: :object,
                description: 'This array is just an example for the lookups,
                              each key will return another array, you can check the model schema from the Schemas section at the end of the documentation',
                properties: {
                  id: { type: :integer, example: 1 },
                  name: { type: :string, example: 'Usher' }
                }
              } }
            }
          ),
          error: {
            type: :object,
            required: %w[success message],
            properties: {
              success: { type: :boolean, description: 'response status failure' },
              message: { type: :string, description: 'validation error message' }
            }
          },
          success: {
            type: :object,
            required: %w[status message],
            properties: {
              status: { type: :boolean, description: 'response success status' },
              message: { type: :string, description: 'success message' }
            }
          }
        },
        responses: {
          UserApp: {
            User: {
              Show: response_model_schema_ref('DetailedUser', 'user')
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
