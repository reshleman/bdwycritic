class CreateEventPreferences < ActiveRecord::Migration
  def change
    create_table :event_preferences do |t|
      t.references :user, index: true, null: false
      t.references :event, index: true, null: false
      t.boolean :wants_to_see

      t.timestamps
    end
  end
end
