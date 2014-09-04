class CurrentEventsDashboardController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @events = Event.current.with_review_statistics
  end
end
