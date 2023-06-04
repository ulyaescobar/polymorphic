Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/authenticate', to: 'authentication#authenticate'
  get '/me', to: 'authentication#user_login'
  get '/likes/count/:id', to: 'tweets#count_likes'
  get '/comments/count/:tweet_id', to: 'comments#count_comment'
  put '/update_avatar', to: 'users#update_avatar'
  resources :users
  resources :projects
  resources :images
  resources :tweets do
    post 'retweet', on: :member
    resources :likes, only: [:create, :index, :destroy]
    resources :comments
  end
  resources :notifications, only: [:index] do
    patch :mark_as_read, on: :member
  end

end
