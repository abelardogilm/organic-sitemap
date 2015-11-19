module OrganicSitemap
  class CacheManager
    def self.uncached_urls(expiration_time:, url_pattern: "")
      opts = {from: Time.now, to: to(expiration_time)}
      urls = OrganicSitemap::RedisManager.sitemap_urls(opts)
      urls.select{|x| x[url_pattern]}
    end

    private
    def self.to(expiration_time)
      Time.now + OrganicSitemap.configuration.expiry_time.days - expiration_time
    end
  end
end
