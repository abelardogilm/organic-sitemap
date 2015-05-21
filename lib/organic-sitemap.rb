require 'organic-sitemap/version'
require 'organic-sitemap/redis_manager'
require 'organic-sitemap/configuration'
require 'organic-sitemap/url_processor'
require 'redis'

if defined? Rails
  require 'organic-sitemap/railtie'
  require 'organic-sitemap/middleware/url_capture' if defined? Rails
end

module OrganicSitemap
end
