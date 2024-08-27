Rails.application.routes.draw do

  
  get 'sessions/new'
  # Put your routes here
  root to: 'health_check#index'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  ######################
  require 'sidekiq/web'
  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'
  # Sidekiq route
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
  end
  mount Sidekiq::Web => '/sidekiq'

  # Swagger route
  mount Rswag::Ui::Engine => 'api-docs'
  mount Rswag::Api::Engine => 'api-docs'

  resources :books
  resources :users, only: %i[show]
  resources :users do
    collection do
      post :forgot_password
      post :reset_password
    end
  end
end
