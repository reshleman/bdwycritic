class TopMediaEventsDashboardController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @events = Event.current.by_average_media_review
  end
end
