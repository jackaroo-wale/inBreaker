Rails.application.routes.draw do
  get 'weekly_answers/create'
  get 'weekly_questions/index'
  get 'weekly_questions/show'
  get 'weekly_questions/new'
  get 'weekly_questions/create'
  get 'initial_answers/create'
  get 'initial_questions/index'
  get 'initial_questions/show'
  get 'initial_questions/new'
  get 'initial_questions/create'
  get 'teams/index'
  get 'teams/show'
  get 'teams/new'
  get 'teams/create'
  get 'members/index'
  get 'members/show'
  get 'members/new'
  get 'members/create'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
