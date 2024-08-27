# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis'
# Use Active Model has_secure_password
gem 'bcrypt'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Adding the worker gems
gem 'redis-rails'

gem 'sidekiq'

gem 'sidekiq-scheduler'

gem 'jwt'
# for awesome printing
gem 'awesome_print'
# serializer
gem 'jsonapi-serializer'
gem 'active_model_serializers'

# fastest pagination
gem 'pagy'
# policies
gem 'pundit'

# firebase
gem 'fcm'
gem 'firebase'
# for dynamic links
gem 'firebase_dynamic_link'

# to extract the country codes
gem 'phone'

# To translate some seeds like Countries
gem 'easy_translate'

# carrierwave uplaoder
gem 'carrierwave'

gem 'carrierwave-base64'

gem 'carrierwave-aws'

# # elasticsearch gems
# gem 'elasticsearch'
# gem 'elasticsearch-model'
# gem 'elasticsearch-rails'

gem 'rswag-api'
gem 'rswag-ui'

gem 'rubocop'
gem 'traco'

# To provide support for the spatial data types and features added by the PostGIS extension
gem 'activerecord-postgis-adapter'

# social registration

gem 'apple_id'
gem 'google-id-token'
gem 'httparty'
gem 'simple_command'


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rswag-specs'
end

group :development do
  # Annotate models on migrate
  gem 'annotate'
  gem 'bullet'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
