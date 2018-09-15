Rails.application.routes.draw do
  resources :questions do
    resources :votes, only: [:create, :destroy]
    resources :answers do
      resources :votes, only: [:create, :destroy]
    end
  end
  resources :users
  resource :session, only: [:new, :create, :destroy]
  get "api", to: 'apis#index'
  root 'questions#index'


  namespace :api do
    resource :token, :controller=>"sessions", only: :create
    get 'profile', to: 'users#profile'
    resources :users do
      resources :questions, :controller=>"users/questions", only: [:index, :show]
    end
    resources :questions do
        resources :answers do
         patch 'accept', to: 'answers#accept'
         patch 'reject', to: 'answers#reject'
        end
    end
  end 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
