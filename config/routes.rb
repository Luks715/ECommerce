Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :carrinhos
  resources :categoria
  resources :clientes
  resources :vendedors
  resources :user
  resources :reviews
  resources :produtos

  get 'home_user', to: 'pages#home_user', as: 'home_user'
  get 'search', to: 'pages#search', as: 'search_pages'
  root to: "pages#home_user"



  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
