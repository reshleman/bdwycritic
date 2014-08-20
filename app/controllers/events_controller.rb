class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def show
    @event = Event.find(params[:id])
  end

  def index
    @current_events = Event.current
    @closed_events = Event.closed

    @nyt_events_query = NytEvents::Query.new(filters: 'category: "Theater"', limit: 3)
  end
end
