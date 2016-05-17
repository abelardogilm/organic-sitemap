module OrganicSitemap
  module Middleware
    class UrlCapture
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)
        processor = OrganicSitemap::UrlProcessor.new(status, headers, Rack::Request.new(env))
        if processor.sitemap_url?
          OrganicSitemap::RedisManager.add(processor.sanitize_path_info)
        elsif processor.cleanable_url?
          OrganicSitemap::RedisManager.remove_key(key: processor.sanitize_path_info)
        end
        [status, headers, response]
      end
    end
  end
end
