namespace :events do
  desc "Import events from NY Times"
  task import: :environment do
    EventsImporter.new.import_events
  end
end
