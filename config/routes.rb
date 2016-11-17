Rails.application.routes.draw do
  root 'users#show'

  get '/auth/github/callback', to: 'sessions#create'

  get '/projects/show', to: 'projects#show'

  post '/developerprojects/create', to: 'developerprojects#create'

  put '/developerprojects/edit', to: 'developerprojects#update'

  resources :projects, only: [:index, :create, :update]
end
