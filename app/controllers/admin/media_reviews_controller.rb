class Admin::MediaReviewsController < AdminController
  def new
    @event = find_event
    @media_review = MediaReview.new
  end

  def create
    @event = find_event
    @media_review = MediaReview.new_with_analysis(
      media_review_params,
      media_review_text
    )

    if @event.media_reviews << @media_review
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @media_review = find_media_review
  end

  def update
    @media_review = find_media_review

    if @media_review.update(media_review_params)
      redirect_to @media_review.event
    else
      render :edit
    end
  end

  private

  def find_event
    Event.find(params[:event_id])
  end

  def find_media_review
    MediaReview.find(params[:id])
  end

  def media_review_params
    params.
      require(:media_review).
      permit(:url, :source, :headline, :author)
  end

  def media_review_text
    params[:media_review_text]
  end
end
