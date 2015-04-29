require "organic-sitemap/version"
if defined? Rails
  require "organic-sitemap/railtie"
  require "organic-sitemap/middleware/url_capture" if defined? Rails
end

module OrganicSitemap

end
