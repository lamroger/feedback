Rails.application.routes.draw do
  resources :responses do
    post :sanitize_message, on: :new
  end
  resources :surveys
  devise_for :users
  get '/r/:public_id', to: 'responses#public_response', as: 'public_response'

  root 'home#index'
end
