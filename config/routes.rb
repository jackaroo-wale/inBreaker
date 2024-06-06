Rails.application.routes.draw do
  devise_for :users


  resources :teams do
    resources :members, only: [:new, :create, :show, :index]
  end

  resources :weekly_questions, only: [:index, :show, :new, :create] do
    resources :weekly_answers, only: [:create]
  end
  resources :weekly_answers, only: [:show]

  resources :initial_questions, only: [:index, :show] do
    resources :initial_answers, only: [:create]
  end
  resources :initial_answers, only: [:show]

  get "users/search", to: "users#search"

  root 'pages#home'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
