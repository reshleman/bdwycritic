require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  constraints Monban::Constraints::SignedIn.new do
    root "current_events_dashboard#show", as: :dashboard
  end

  constraints Monban::Constraints::SignedOut.new do
    root "sessions#new"
  end

  resources :events, only: [:show] do
    resources :user_reviews, only: [:new, :create]
    resources :event_preferences, only: [:create], as: :preferences

    collection do
      get "current" => "current_events_dashboard#show"
      get "closed" => "closed_events_dashboard#show"
    end
  end

  resource :search_results, only: [:show], as: :search

  namespace :admin do
    root "events#new", as: :dashboard

    resources :events, only: [:new, :create] do
      resources :media_reviews, only: [:new, :create]
    end

    resources :user_reviews, only: [:edit, :update, :destroy]
    resources :media_reviews, only: [:edit, :update, :destroy]
  end
end
