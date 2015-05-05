module OrganicSitemap
  class Railtie < Rails::Railtie
    initializer "organic-sitemap.insert_middleware" do |app|
      app.config.middleware.use "OrganicSitemap::Middleware::UrlCapture"
    end
  end
end