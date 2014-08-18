class Admin::EventsController < AdminController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  private

  def event_params
    params.
      require(:event).
      permit(:name, :venue, :description, :closing_date)
  end
end
