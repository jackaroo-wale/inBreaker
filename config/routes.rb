Rails.application.routes.draw do
  devise_for :users
  
  resources :users do
    resources :members do
      resources :teams do
        resources :weekly_questions, only: [:index, :show] do
          resources :weekly_answers, only: [:create]
        end
      end
    end
    resources :initial_questions, only: [:index, :show] do
      resources :initial_answers, only: [:create]
    end
  end

  resources :weekly_questions, only: [:index, :show, :new, :create]

  root 'users#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
