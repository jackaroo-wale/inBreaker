Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

<<<<<<< HEAD
  resources :teams, only: [:new, :create, :index] do
=======
  resources :teams, only: [:new, :create,:index, :show] do
>>>>>>> master
    resources :members
  end

  resources :weekly_questions, only: [:index, :show] do
    post 'create_answer', on: :member
    resources :weekly_answers, only: [:create]
  end

  resources :weekly_answers, only: [:show]

  resources :initial_questions, only: [:index, :show] do
    resources :initial_answers, only: [:create]
  end

  resources :initial_answers, only: [:show]

  get "users/search", to: "users#search"

  root 'pages#home'

  get "up" => "rails/health#show", as: :rails_health_check
end
