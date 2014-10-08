require "rails_helper"

describe UserReviewsController do
  before do
    @user_review = create(:user_review, user: create(:user))
    sign_in(create(:user))
  end

  describe "#edit" do
    it "redirects a user who did not create the user review with that id" do
      get :edit, id: @user_review.id

      expect_redirect_to_event
      expect_flash_with_not_authorized_message
    end
  end

  describe "#update" do
    it "redirects a user who did not create the user review with that id" do
      put(:update, id: @user_review.id, user_review: @user_review.attributes)

      expect_redirect_to_event
      expect_flash_with_not_authorized_message
    end
  end

  def expect_redirect_to_event
    expect(response).to redirect_to(@user_review.event)
  end

  def expect_flash_with_not_authorized_message
    expect(flash[:alert]).to match(/not authorized/)
  end
end
