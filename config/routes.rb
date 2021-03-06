Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  root "current_events_dashboard#show"

  resources :events, only: [:show], shallow: true do
    resources :user_reviews, only: [:new, :create, :edit, :update]
    resources :event_preferences, only: [:create], as: :preferences

    collection do
      get "current" => "current_events_dashboard#show"
      get "closed" => "closed_events_dashboard#show"
      get "top_critic" => "top_media_events_dashboard#show"
      get "top_user" => "top_user_events_dashboard#show"
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
