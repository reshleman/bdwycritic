class SearchResultsController < ApplicationController
  skip_before_action :require_login, only: :show

  def show
    @search_query = params[:event_name]
    @search_results = Event.search(@search_query)
  end
end
