Rails.application.routes.draw do
  get 'private_messages/create'
  get 'conversations/index'
  get 'conversations/create'
  get 'conversations/show'
  get 'messages/create'
  get 'chatrooms/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :teams, only: [:new, :create, :index, :show] do
    resources :members

    member do
      get 'play', to: 'pages#play'
      post 'check_answer', to: 'pages#check_answer'
      get 'next_question', to: 'pages#next_question'
      get 'finish', to: 'pages#finish'
    end

    resources :chatrooms, only: [:show, :create] do
      resources :messages, only: [:create]
    end
  end

  resources :conversations, only: [:index, :create, :show] do
    resources :private_messages, only: [:create]
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
