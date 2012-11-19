Dake::Application.routes.draw do
  devise_for :users
  
  resources :users, only: [:show] do
    member do
      get :followers, :following
      put :follow, :unfollow
    end
    collection do
      put  :update_profile
      put  :update_password
      put  :update_avatar
    end
  end
  
  resources :messages, only: [:create,:destroy] do
    put :read, on: :member
  end
  
  resources :conversations, only: [:index, :show]
  resources :photos, only: [:create, :destroy]
end
