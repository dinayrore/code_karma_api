Rails.application.routes.draw do
  root 'users#show'

  get '/auth/github/callback', to: 'sessions#create'

  get '/projects/show', to: 'projects#show'

  resources :projects, only: [:index]
end
