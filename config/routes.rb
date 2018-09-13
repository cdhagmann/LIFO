Rails.application.routes.draw do
  resources :questions do
    resources :answers do
      resources :votes, only: [:create, :destroy]
    end
  end
  resources :users
  resource :session, only: [:new, :create, :destroy]
  root 'questions#index'


  namespace :api do
    resource :token, :controller=>"session", only: :create
    get 'profile', to: 'users#profile'
    resources :users
    resources :questions do
        resources :answers
    end
  end 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
