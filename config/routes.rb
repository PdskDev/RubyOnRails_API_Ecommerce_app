Rails.application.routes.draw do
  # get "up" => "rails/health#show", as: :rails_health_check
  #API definition
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: %i[index show create update destroy]
      resources :tokens, only: [:create]
    end
  end 
end
