Rails.application.routes.draw do
  # get "up" => "rails/health#show", as: :rails_health_check
  #API definition
  namespace :api, default : {format: :json} do
    namespace :v1 do
    # resource list
    end
  end 
end
