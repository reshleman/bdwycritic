class UrlSourceExtractor
  SOURCES = YAML.load_file(Rails.root.join("config", "url_sources.yaml"))

  def initialize(url)
    @url_domain = host_for(url)
  end

  def source
    matching_sources.first || @url_domain
  end

  private

  def host_for(url)
    URI.parse(url).host
  end

  def matching_sources
    SOURCES.select do |domain, _source|
      url_domain_ends_with(domain)
    end.values
  end

  def url_domain_ends_with(domain)
    @url_domain =~ /#{domain}\Z/
  end
end
