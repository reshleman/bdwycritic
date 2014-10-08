require "rails_helper"

describe UserReview do
  describe "#created_by?" do
    context "when the given user created the user review" do
      it "returns true" do
        user = create(:user)
        user_review = create(:user_review, user: user)

        expect(user_review.created_by?(user)).to be true
      end
    end

    context "when the given user did not create the user review" do
      it "returns false" do
        user = create(:user)
        another_user = create(:user)
        user_review = create(:user_review, user: another_user)

        expect(user_review.created_by?(user)).to be false
      end
    end
  end
end
