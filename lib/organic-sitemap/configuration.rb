module OrganicSitemap
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :storage, :storage_key, :domains, :allowed_params,
                  :skipped_urls, :redis_connection, :expiry_time,
                  :clean_redirects, :clean_not_found
    attr_accessor :crawler_domain, :crawler_delay

    def initialize
      @storage          = 'redis'
      @storage_key      = 'sitemap-urls'
      @allowed_params   = []
      @skipped_urls     = []
      @redis_connection = Redis.new(url: 'redis://127.0.0.1:6379')
      @clean_redirects  = false
      @clean_not_found  = false
      @expiry_time      = 7
      @crawler_delay    = nil
    end
  end
end
