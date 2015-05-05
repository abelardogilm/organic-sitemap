module OrganicSitemap
  class RedisManager
    def self.add(key)
      OrganicSitemap.redis_connection.zadd('sitemap-urls',
                                          Time.now.to_i + OrganicSitemap.expiry_time,
                                          key)
    end

    def self.clean_set(time = Time.now)
      OrganicSitemap.redis_connection.zremrangebyscore('sitemap-urls', "-inf", time.to_i)
    end

    def self.sitemap_urls(from: nil, to: nil)
      from = from ? from.to_time.to_i : '-inf'
      to = to ? to.to_time.to_i : '+inf'
      OrganicSitemap.redis_connection.zrangebyscore('sitemap-urls', from, to)
    end
  end
end
