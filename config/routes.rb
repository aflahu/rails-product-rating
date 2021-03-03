Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  resources :products do
    resources :purchases
  end
  
  resources :reviews
  resources :stores
end
