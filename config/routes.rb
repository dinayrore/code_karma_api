Rails.application.routes.draw do
  root 'users#show'

  get '/auth/github/callback', to: 'sessions#create'

  get '/projects/show', to: 'projects#show'

  get '/developer_projects/show', to: 'developerprojects#show'

  resources :developer_projects, only: [:create, :update]
  resources :projects, only: [:index, :create, :update]
  resources :clients, only: [:show]
end
