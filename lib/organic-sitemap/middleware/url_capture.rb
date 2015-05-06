module OrganicSitemap
  module Middleware
    class UrlCapture
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)
        request = Rack::Request.new env
        if sitemap_url(status, headers, response, request, env)
          OrganicSitemap::RedisManager.add(request.path_info)
        end
        [status, headers, response]
      end

      def sitemap_url(status, headers, response, request, env)
        success_response(status) && html_page(response) && request.get? && is_expected_domain?(request)
      end

      def success_response(status)
        status == 200
      end

      def html_page(response)
        response.content_type.include? "text/html"
      end

      def is_expected_domain?(request)
        # Any domain if not explicitly configured
        return true if !OrganicSitemap.domains || OrganicSitemap.domains.empty?
        OrganicSitemap.domains.include? request.host
      end
    end
  end
end
