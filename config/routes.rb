Rails.application.routes.draw do
  root 'locations#index'

  get '/locations',       to: 'locations#index'
  post '/location/lookup', to: 'locations#create'

end

