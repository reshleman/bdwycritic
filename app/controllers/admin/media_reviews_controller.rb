class Admin::MediaReviewsController < AdminController
  def new
    @event = find_event
    @media_review = MediaReview.new
  end

  def create
    @event = find_event
    @media_review = AnalyzedMediaReview.new(MediaReview.new(media_review_params))

    unless @media_review.save
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

  def destroy
    media_review = find_media_review
    event = media_review.event
    media_review.destroy

    redirect_to event
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
      permit(:url, :source, :headline, :author).
      merge(event_id: params[:event_id])
  end
end
