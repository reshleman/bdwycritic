require "rails_helper"

describe UrlSourceExtractor do
  describe "#source" do
    context "with a known source" do
      it "returns the text name of the source for a given URL" do
        extractor = UrlSourceExtractor.new("http://www.nytimes.com")
        another_extractor = UrlSourceExtractor.new("http://www.newyorker.com")

        expect(extractor.source).to match(/New York Times/)
        expect(another_extractor.source).to match(/New Yorker/)
      end
    end

    context "with an unknown source" do
      it "returns the host name of the given url without the path" do
        extractor = UrlSourceExtractor.new("http://unknown.host.name/path/foo")

        expect(extractor.source).to eq("unknown.host.name")
      end
    end
  end
end
