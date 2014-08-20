class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def show
    @event = Event.find(params[:id])
  end

  def index
    @current_events = Event.current
    @closed_events = Event.closed
  end
end
