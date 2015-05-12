require 'organic-sitemap/version'
require 'organic-sitemap/redis_manager'
require 'organic-sitemap/configuration'
if defined? Rails
  require 'organic-sitemap/railtie'
  require 'organic-sitemap/middleware/url_capture' if defined? Rails
end

module OrganicSitemap
  extend Configuration

  define_setting :storage,          'redis'
  define_setting :redis_key,        'sitemap-urls'
  define_setting :domains
  define_setting :skipped_params,   ['utm']
  define_setting :redis_connection, Redis.new(url: 'redis://127.0.0.1:6379')
  define_setting :expiry_time,      7.days
end
