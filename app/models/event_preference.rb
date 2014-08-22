class EventPreference < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user, presence: true
  validates :event, presence: true
end
