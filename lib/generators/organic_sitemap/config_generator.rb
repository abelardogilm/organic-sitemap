module OrganicSitemap
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    desc "Generates the config initializer file for Organic Sitemap"
    def copy_initializer_file
      copy_file "organic_sitemap.rb", "config/initializers/organic_sitemap.rb"
    end
  end
end
