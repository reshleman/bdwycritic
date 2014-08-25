class Admin::UserReviewsController < ApplicationController
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

  def find_user_review
    UserReview.find(params[:id])
  end

  def user_review_params
    params.require(:user_review).permit(:body, :rating)
  end
end
