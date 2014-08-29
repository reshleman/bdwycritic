module EventsHelper
  def description_credit(event)
    if data_from_nyt?(event)
      content_tag :em, " —via the New York Times"
    end
  end

  private

  def data_from_nyt?(event)
    event.nyt_event_id
  end
end
