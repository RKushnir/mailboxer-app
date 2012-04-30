Messaging::Application.routes.draw do
  root to: 'home#show'

  devise_for :users
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
end
