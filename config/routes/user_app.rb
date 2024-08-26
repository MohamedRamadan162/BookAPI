#################### User App ####################
namespace :user_app do
  namespace :v1 do
    resources :users, only: %i[create]
  end
end
