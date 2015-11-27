module OrganicSitemap
  class CrawlerManager
    def self.warmup(urls, opts = {})
      data = {urls: [*urls],
              valids: 0,
              invalids: {}}

      data[:urls].each do |uri|
        p "OrganicSitemap::CrawlerManager GET: #{uri}"
        response = HTTParty.get(url_for(uri), opts)

        url_processed = OrganicSitemap::UrlProcessor.new(response.code, response.headers, response.request)

        unless url_processed.url_from_cache_valid?
          p "OrganicSitemap::CrawlerManager REMOVING URL: #{uri} response code: #{response.code}"
          OrganicSitemap::RedisManager.remove_key(key: uri)
          if data[:invalids][response.code]
            data[:invalids][response.code] << uri
          else
            data[:invalids][response.code] = [uri]
          end
        else
          data[:valids] += 1
        end
        sleep crawler_delay if crawler_delay
      end
      data
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
