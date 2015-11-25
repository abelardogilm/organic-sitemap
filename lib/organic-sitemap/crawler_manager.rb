module OrganicSitemap
  class CrawlerManager
    def self.warmup(urls, opts = {})
      [*urls].each do |uri|
        p "OrganicSitemap::CrawlerManager GET: #{uri}"
        response = HTTParty.get(url_for(uri), opts)

        url_processed = OrganicSitemap::UrlProcessor.new(response.code, response.headers, response.request)

        unless url_processed.url_from_cache_valid?
          p "OrganicSitemap::CrawlerManager REMOVING URL: #{uri} invalid url"
          OrganicSitemap::RedisManager.remove_key(key: uri)
        end
        sleep crawler_delay if crawler_delay
      end
    end

    private

    def self.url_for(uri)
      "#{OrganicSitemap.configuration.crawler_domain}#{uri}"
    end
    def self.crawler_delay
      OrganicSitemap.configuration.crawler_delay
    end
  end
end
