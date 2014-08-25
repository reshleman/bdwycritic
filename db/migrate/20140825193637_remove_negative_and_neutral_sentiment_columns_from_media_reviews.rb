class RemoveNegativeAndNeutralSentimentColumnsFromMediaReviews < ActiveRecord::Migration
  def change
    rename_column :media_reviews, :sentiment_positive, :sentiment

    remove_column :media_reviews, :sentiment_negative, :float
    remove_column :media_reviews, :sentiment_neutral, :float
  end
end
