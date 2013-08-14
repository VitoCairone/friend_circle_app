FriendCircleApp::Application.routes.draw do
  resources :users, :except => [:index]
  resource :session, :only => [:create, :new, :destroy]
  resources :friend_circles
  resources :posts
  get '/feed', to: 'users#feed'
end
