class UserReviewsController < ApplicationController
  def new
    @event = find_event
    @user_review = UserReview.new
  end

  def create
    @event = find_event
    @user_review = UserReview.new(user_review_params)

    if current_user.user_reviews << @user_review
      redirect_to @event
    else
      render :new
    end
  end

  private

  def find_event
    Event.find(params[:event_id])
  end

  def user_review_params
    params.
      require(:user_review).
      permit(:body, :rating).
      merge(event_id: @event.id)
  end
end
