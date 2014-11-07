require "rails_helper"

vcr_options = { cassette_name: "media_review_metadata" }

describe MediaReviewMetadataExtractor, vcr: vcr_options do
  before do
    @media_review = build_stubbed(:media_review)
    @extractor = MediaReviewMetadataExtractor.new(@media_review.url)
  end

  describe "#title" do
    it "returns the title for the given url" do
      expect(@extractor.title).to match(/#{@media_review.headline}/)
    end
  end

  describe "#author" do
    it "returns the author for the given url" do
      expect(@extractor.author).to match(/#{@media_review.author}/)
    end
  end

  describe "#sentiment" do
    it "returns the numerical sentiment for the given url" do
      expect(@extractor.sentiment).to match(/#{@media_review.sentiment}/)
    end
  end

  describe "#analyzed_text" do
    it "returns the text that was analyzed for sentiment" do
      expect(@extractor.analyzed_text).to be_a(String)
      expect(@extractor.analyzed_text).not_to eq ""
    end
  end

  describe "#source" do
    it "returns the text source for the given url" do
      expect(@extractor.source).to match(/#{@media_review.source}/)
    end
  end
end
