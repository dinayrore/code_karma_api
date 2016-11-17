Rails.application.routes.draw do
  root 'users#show'

  get '/auth/github/callback', to: 'sessions#create'

  get '/projects/show', to: 'projects#show'

  get '/developer_projects/show', to: 'developerprojects#show'

  resources :developer_projects, only: [:create, :update, :destroy]
  resources :projects, only: [:index, :create, :update, :destroy]
  resources :clients, only: [:show]
  resources :developers, only: [:show]
end
