# frozen_string_literal: true

Rails.application.routes.draw do
  resources :questions do
    resources :votes, only: %i[create destroy]
    resources :answers do
      resources :votes, only: %i[create destroy]
    end
  end
  resources :users
  resource :session, only: %i[new create destroy]
  get 'api', to: 'apis#index'
  root 'questions#index'

  namespace :api do
    resource :token, controller: 'sessions', only: :create
    get 'profile', to: 'users#profile'
    resources :users do
      resources :questions, controller: 'users/questions', only: %i[index show]
    end
    resources :questions do
      post 'upvote', to: 'votes#upvote'
      post 'downvote', to: 'votes#downvote'
      resources :answers do
        patch 'accept', to: 'answers#accept'
        patch 'reject', to: 'answers#reject'
        post 'upvote', to: 'votes#upvote'
        post 'downvote', to: 'votes#downvote'
      end
    end
  end
end
