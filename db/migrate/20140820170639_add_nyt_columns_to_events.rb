class AddNytColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :nyt_event_id, :integer, index: true
    add_column :events, :nyt_updated_at, :datetime
  end
end
