class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :venue
      t.text :description
      t.date :closing_date

      t.timestamps
    end
  end
end
