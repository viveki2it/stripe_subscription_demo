Rails.application.routes.draw do
  get 'home/index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :subscriptions, only: [] do
    collection do
      get :success_checkout
      get :cancel_checkout
      post :create_checkout_session
    end
  end
  resources :webhooks, only: :create
end
