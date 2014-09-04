class ClosedEventsDashboardController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @events = Event.closed.with_review_statistics
  end
end
