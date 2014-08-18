require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  constraints Monban::Constraints::SignedIn.new do
    root "events#index", as: :dashboard
  end

  constraints Monban::Constraints::SignedOut.new do
    root "sessions#new"
  end

  resources :events, only: [:show, :index] do
    resources :user_reviews, only: [:new, :create]
  end

  namespace :admin do
    root "events#new", as: :dashboard
    resources :events, only: [:new, :create] do
      resources :media_reviews, only: [:new, :create]
    end
  end
end
