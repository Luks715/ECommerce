Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :carrinhos
  resources :categoria
  resources :clientes do
    member do
      get 'add_saldo'  # Para exibir o formulário de adicionar saldo
      patch 'add_saldo' # Para processar a adição de saldo
    end
  end
  resources :vendedors
  resources :user
  resources :review_produtos
  resources :review_vendedors
  resources :produtos

  post 'criar_pedido', to: 'pedidos#create'

  delete 'pedidos/destroy', to: 'pedidos#destroy', as: 'pedidos_destroy'

  get 'acompanhar_entrega', to: 'pages#acompanhar_entrega', as: 'acompanhar_entrega'
  get 'home_user', to: 'pages#home_user', as: 'home_user'
  get 'search', to: 'pages#search', as: 'search_pages'

  patch 'clientes/:id/add_saldo', to: 'clientes#add_saldo', as: 'add_saldo'

  root to: "pages#home_user"


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
