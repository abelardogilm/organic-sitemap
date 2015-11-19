require 'organic-sitemap/version'
require 'organic-sitemap/redis_manager'
require 'organic-sitemap/configuration'
require 'organic-sitemap/url_processor'
require 'organic-sitemap/cache_manager'
require 'organic-sitemap/crawler_manager'
require 'redis'
require 'httparty'

if defined? Rails
  require 'organic-sitemap/railtie'
  require 'organic-sitemap/middleware/url_capture' if defined? Rails
end

module OrganicSitemap
end
