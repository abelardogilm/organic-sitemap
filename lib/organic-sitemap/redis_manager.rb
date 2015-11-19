module OrganicSitemap
  class RedisManager
    def self.add(key)
      return unless key
      redis_connection.zadd(storage_key, (DateTime.now + expiry_time).to_time.to_i, key)
    end

    def self.clean_set(time = Time.now)
      redis_connection.zremrangebyscore(storage_key, "-inf", time.to_i)
    end

    def self.sitemap_urls(from: nil, to: nil)
      from = from ? from.to_time.to_i : '-inf'
      to = to ? to.to_time.to_i : '+inf'
      redis_connection.zrangebyscore(storage_key, from, to)
    end

    def self.remove_key(key: nil)
      return if key.nil?
      redis_connection.zrem(storage_key, key)
    end

    def self.remove_keys(keys: [])
      return unless keys.any?
      keys.each do |key|
        remove_key key
      end
    end

    private
    def self.redis_connection
      OrganicSitemap.configuration.redis_connection
    end

    def self.storage_key
      OrganicSitemap.configuration.storage_key
    end

    def self.expiry_time
      OrganicSitemap.configuration.expiry_time.to_i
    end
  end
end
