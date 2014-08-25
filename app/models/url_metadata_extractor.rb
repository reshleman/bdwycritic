class UrlMetadataExtractor
  def initialize(url)
    @url = url
  end

  def author
    AlchemyAPI::AuthorExtraction.new.search(url: url)["author"]
  end

  def title
    AlchemyAPI::TitleExtraction.new.search(url: url)
  end

  private

  attr_reader :url
end
