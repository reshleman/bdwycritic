class CreateUserReviews < ActiveRecord::Migration
  def change
    create_table :user_reviews do |t|
      t.text :body, null: false
      t.integer :rating, null: false
      t.references :user, null: false, index: true
      t.references :event, null: false, index: true

      t.timestamps
    end
  end
end
