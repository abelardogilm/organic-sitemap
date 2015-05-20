require 'organic-sitemap/version'
require 'organic-sitemap/redis_manager'
require 'organic-sitemap/configuration'
require 'redis'

if defined? Rails
  require 'organic-sitemap/railtie'
  require 'organic-sitemap/middleware/url_capture' if defined? Rails
end

module OrganicSitemap
end
