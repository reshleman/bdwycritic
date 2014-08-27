class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def show
    @event = Event.
      with_review_statistics.
      includes(:media_reviews, :user_reviews, :reviewing_users).
      find(params[:id])
  end

  def index
    @current_events = Event.current.with_review_statistics
    @closed_events = Event.closed.with_review_statistics
  end
end
