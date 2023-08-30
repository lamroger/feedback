Rails.application.routes.draw do
  resources :responses do
    post :sanitize_message, on: :new
  end
  resources :surveys
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
end
