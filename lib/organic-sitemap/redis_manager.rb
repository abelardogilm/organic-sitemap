module OrganicSitemap
  class RedisManager
    def self.add(key)
      OrganicSitemap.redis_connection.zadd(OrganicSitemap.storage_key,
                                          Time.now.to_i + OrganicSitemap.expiry_time.to_i.days,
                                          key)
    end

    def self.clean_set(time = Time.now)
      OrganicSitemap.redis_connection.zremrangebyscore(OrganicSitemap.storage_key,
                                                       "-inf",
                                                       time.to_i)
    end

    def self.sitemap_urls(from: nil, to: nil)
      from = from ? from.to_time.to_i : '-inf'
      to = to ? to.to_time.to_i : '+inf'
      OrganicSitemap.redis_connection.zrangebyscore(OrganicSitemap.storage_key,
                                                    from,
                                                    to)
    end
  end
end
