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
                  :skipped_urls, :redis_connection, :expiry_time

    def initialize
      @storage          = 'redis'
      @storage_key      = 'sitemap-urls'
      @allowed_params   = []
      @skipped_urls     = []
      @redis_connection = Redis.new(url: 'redis://127.0.0.1:6379')
      @expiry_time      = 7
    end
  end
end
