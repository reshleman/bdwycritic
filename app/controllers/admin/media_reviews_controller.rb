class Admin::MediaReviewsController < AdminController
  def new
    @event = find_event
    @media_review = MediaReview.new
  end

  def create
    @event = find_event
    @media_review = MediaReview.new_with_analysis(media_review_params, review_text)

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
      permit(:url, :source, :headline, :author)
  end

  def review_text
    params[:media_review_text]
  end
end
