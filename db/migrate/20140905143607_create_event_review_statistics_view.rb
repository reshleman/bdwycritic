class CreateEventReviewStatisticsView < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW event_review_statistics AS
        SELECT
          events.id as event_id,
          AVG(user_reviews.rating) AS average_user_review,
          AVG(media_reviews.sentiment) AS average_media_review
        FROM
          events
          LEFT JOIN user_reviews ON events.id = user_reviews.event_id
          LEFT JOIN media_reviews ON events.id = media_reviews.event_id
        GROUP BY
          events.id
    SQL
  end

  def down
    execute "DROP VIEW event_review_statistics"
  end
end
