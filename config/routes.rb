Rails.application.routes.draw do
  root 'users#show'

  get '/auth/github/callback', to: 'sessions#create'
  get '/developer/total/user/points', to: 'developer#total_karma'
  post '/projects/:id', to: 'projects#fork'
  put '/karmaquestion/added_like', to: 'karma_question#added_like'
  put '/karmacomment/added_like', to: 'karma_comment#added_like'

  resources :developer_projects, only: [:show, :create, :update, :destroy]
  resources :projects, only: [:index, :show, :create, :update, :destroy]
  resources :clients, only: [:show]
  resources :developers, only: [:show]
  resources :karma_question, only: [:index, :create, :update, :destroy]
  resources :karma_comments, only: [:create, :update, :destroy]
end
