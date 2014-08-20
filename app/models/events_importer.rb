class EventsImporter
  def initialize
    @nyt_events = fetch_nyt_events
  end

  def import_events
    nyt_events.each do |nyt_event|
      import_event(nyt_event)
    end
  end

  private

  attr_reader :nyt_events

  def fetch_nyt_events
    query = NytEvents::Query.new(
      filters: 'category: "Theater", subcategory: "Broadway"',
      limit: 500
    )
    query.events
  end

  def import_event(source)
    event = Event.find_or_initialize_by(nyt_event_id: source.event_id)

    if event.new_record? || event.older_than_nyt?(source.last_modified)
      update_or_create_from(event, source)
    end
  end

  def update_or_create_from(event, source)
    event.name = strip_single_quotes(source.event_name)
    event.description = strip_p_tags(source.web_description)
    event.venue = source.venue_name
    event.closing_date = source.recurring_end_date
    event.nyt_updated_at = source.last_modified
    event.save!
  end

  def strip_single_quotes(string)
    string.strip.gsub(/\A‘|’\Z/, "")
  end

  def strip_p_tags(string)
    string.strip.gsub(/\A<p>|<\/p>\Z/, "")
  end
end
