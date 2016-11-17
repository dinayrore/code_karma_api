Rails.application.routes.draw do
  root 'users#show'

  get '/auth/github/callback', to: 'sessions#create'

  get '/projects', to: 'projects#show'

  get '/developerprojects', to: 'developerprojects#show'

  resources :developerprojects, only: [:create, :update, :destroy]
  resources :projects, only: [:index, :create, :update, :destroy]
  resources :clients, only: [:show]
  resources :developers, only: [:show]
end
