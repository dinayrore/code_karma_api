Rails.application.routes.draw do
  root 'users#show'

  get '/auth/github/callback', to: 'sessions#create'

  post '/projects/:id', to: 'projects#fork'

  get '/developers/karma/:id', to: 'developers#karma'
  get '/developers/rank', to: 'developers#rank'

  get '/developer_projects/:id', to: 'developer_projects#github_branches'
  post '/developer_projects/:id', to: 'developer_projects#pull_request'

  put '/karma_question/:id', to: 'karma_questions#like'
  put '/karma_comment/:id', to: 'karma_comments#like'

  resources :developer_projects, only: [:show, :create, :update, :destroy]
  resources :projects, only: [:index, :show, :create, :update, :destroy]
  resources :clients, only: [:show, :update]
  resources :developers, only: [:show, :update]
  resources :karma_questions, only: [:create, :update, :destroy]
  resources :karma_comments, only: [:index, :create, :update, :destroy]
end
