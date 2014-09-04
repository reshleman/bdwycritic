class AddCounterCacheColumnsToEvents < ActiveRecord::Migration
  class Event < ActiveRecord::Base
    has_many :user_reviews
    has_many :media_reviews
  end

  def change
    add_column :events, :num_user_reviews, :integer, default: 0
    add_column :events, :num_media_reviews, :integer, default: 0

    Event.all.each do |event|
      event.num_user_reviews = event.user_reviews.count
      event.num_media_reviews = event.media_reviews.count
      event.save!
    end
  end
end
