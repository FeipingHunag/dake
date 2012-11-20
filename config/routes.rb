Dake::Application.routes.draw do
  resources :locations, only: [:create] do
    collection do
      get :nearby
    end
  end
  devise_for :users, controllers: {registrations: "users/registrations", passwords: "users/passwords"}
  get 'bootstrap_data' => "home#index"
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
