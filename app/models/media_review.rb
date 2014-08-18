class MediaReview < ActiveRecord::Base
  belongs_to :event

  validates :url, presence: true
  validates :event, presence: true
end
