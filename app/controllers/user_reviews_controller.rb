class UserReviewsController < ApplicationController
  before_action :require_ownership, only: [:edit, :update]

  def new
    @event = find_event
    @user_review = UserReview.new
  end

  def create
    @event = find_event
    @user_review = UserReview.new(user_review_params_with_event)

    if current_user.user_reviews << @user_review
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @user_review = find_user_review
  end

  def update
    @user_review = find_user_review

    if @user_review.update(user_review_params)
      redirect_to @user_review.event
    else
      render :edit
    end
  end

  private

  def require_ownership
    unless find_user_review.created_by?(current_user)
      flash[:alert] = "You are not authorized to view that page."
      redirect_to find_user_review.event
    end
  end

  def find_event
    @event ||= Event.find(params[:event_id])
  end

  def find_user_review
    @user_review ||= UserReview.find(params[:id])
  end

  def user_review_params
    params.require(:user_review).permit(:body, :rating)
  end

  def user_review_params_with_event
    user_review_params.merge(event_id: find_event.id)
  end
end
