class EventsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @event = Event.
      includes(user_reviews: :user).
      find(params[:id])
  end
end
