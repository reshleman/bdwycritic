class Admin::MediaReviewsController < AdminController
  def new
    @event = find_event
    @media_review = MediaReview.new
  end

  def create
    @event = find_event
    @media_review = MediaReview.new(media_review_params)

    if @event.media_reviews << @media_review
      redirect_to @event
    else
      render :new
    end
  end

  private

  def find_event
    Event.find(params[:event_id])
  end

  def media_review_params
    params.
      require(:media_review).
      permit(:url)
  end
end
