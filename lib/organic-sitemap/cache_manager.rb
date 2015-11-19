module OrganicSitemap
  class CacheManager
    def self.uncached_url(expiration_time)
      OrganicSitemap::RedisManager.sitemap_urls(from: Time.now, to: to(expiration_time))
    end

    private
    def self.to(expiration_time)
      Time.now + OrganicSitemap.configuration.expiry_time.days - expiration_time
    end
  end
end
