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
    NytEvents::Query.new(filters: 'category: "Theater", subcategory: "Broadway"', limit: 500).events
  end

  def import_event(nyt_event)
    event = Event.find_or_initialize_by(nyt_event_id: nyt_event.event_id)

    if event.new_record? || event.older_than_nyt?(nyt_event.last_modified)
      update_or_create_from(event, nyt_event)
    end
  end

  def update_or_create_from(event, source_event)
    event.name = remove_surrounding_quotes(source_event.event_name)
    event.description = remove_surrounding_p_tags(source_event.web_description)
    event.venue = source_event.venue_name
    event.closing_date = source_event.recurring_end_date
    event.nyt_updated_at = source_event.last_modified
    event.save!
  end

  def remove_surrounding_quotes(string)
    string.gsub(/\A‘|’\Z/, '')
  end

  def remove_surrounding_p_tags(string)
    string.gsub(/\A<p>|<\/p>\Z/, '')
  end
end
