Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/twitter', as: :login
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get 'logout', to: 'sessions#destroy'
end
