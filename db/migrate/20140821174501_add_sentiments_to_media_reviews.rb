class AddSentimentsToMediaReviews < ActiveRecord::Migration
  def change
    add_column :media_reviews, :sentiment_positive, :float
    add_column :media_reviews, :sentiment_negative, :float
    add_column :media_reviews, :sentiment_neutral, :float
  end
end
