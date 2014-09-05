class ReviewStatisticsSummary < ActiveRecord::Base
  self.table_name = "event_review_statistics"
  self.primary_key = "event_id"

  belongs_to :event
end
