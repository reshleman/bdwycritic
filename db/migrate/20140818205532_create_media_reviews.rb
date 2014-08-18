class CreateMediaReviews < ActiveRecord::Migration
  def change
    create_table :media_reviews do |t|
      t.string :url, null: false
      t.references :event, index: true

      t.timestamps
    end
  end
end
