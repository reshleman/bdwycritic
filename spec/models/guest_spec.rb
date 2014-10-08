require "rails_helper"

describe Guest do
  describe "#id" do
    it "returns nil" do
      expect(Guest.new.id).to be nil
    end
  end

  describe "#admin?" do
    it "returns false" do
      expect(Guest.new.admin?).to be false
    end
  end

  describe "#can_review?" do
    it "returns false" do
      event = build(:event)
      guest = Guest.new

      expect(guest.can_review?(event)).to be false
    end
  end
end
