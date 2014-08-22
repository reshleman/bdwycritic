class EventPreferencesController < ApplicationController
  def create
    event = Event.find(params[:event_id])

    if current_user.create_or_update_preference(event, wants_to_see?)
      redirect_to event
    else
      redirect_to event, flash: { error: "Something went wrong." }
    end
  end

  private

  def wants_to_see?
    params[:wants_to_see]
  end
end
