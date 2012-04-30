Messaging::Application.routes.draw do
  root to: 'home#show'

  devise_for :users
  resources :conversations do
    member do
      post :reply
    end
  end
end
