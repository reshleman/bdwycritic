class EventPreferencesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])

    current_user.create_or_update_preference(@event, wants_to_see?)
  end

  private

  def wants_to_see?
    params[:wants_to_see]
  end
end
