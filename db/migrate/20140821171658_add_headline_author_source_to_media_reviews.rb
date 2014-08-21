class AddHeadlineAuthorSourceToMediaReviews < ActiveRecord::Migration
  def change
    add_column :media_reviews, :headline, :string, null: false
    add_column :media_reviews, :author, :string
    add_column :media_reviews, :source, :string, null: false
  end
end
