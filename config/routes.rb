Rails.application.routes.draw do
  root 'users#show'

  get '/auth/github/callback', to: 'sessions#create'
  get '/developer/:id', to: 'developers#karma'
  post '/projects/:id', to: 'projects#fork'
  put '/karma_question/:id', to: 'karma_questions#like'
  put '/karma_comment/:id', to: 'karma_comments#like'

  resources :developer_projects, only: [:show, :create, :update, :destroy]
  resources :projects, only: [:index, :show, :create, :update, :destroy]
  resources :clients, only: [:show]
  resources :developers, only: [:show]
  resources :karma_questions, only: [:create, :update, :destroy]
  resources :karma_comments, only: [:index, :create, :update, :destroy]
end
