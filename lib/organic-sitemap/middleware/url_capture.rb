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
          OrganicSitemap::RedisManager.add(sanitize_path_info(request))
        end
        [status, headers, response]
      end

      private

      def sitemap_url(status, headers, response, request, env)
        success_response(status) && html_page(response) && request.get? && is_expected_domain?(request) && is_allowed_url(request)
      end

      def success_response(status)
        status == 200
      end

      def html_page(response)
        response.content_type.include? "text/html"
      end

      def is_expected_domain?(request)
        # Any domain if not explicitly configured
        return true if OrganicSitemap.domains.nil?
        OrganicSitemap.domains.include? request.host
      end

      def is_allowed_url(request)
        # Any domain if not explicitly configured
        return true unless OrganicSitemap.skipped_urls.any?
        !OrganicSitemap.skipped_urls.include? request.path
      end

      def sanitize_path_info(request)
        query_string = Rack::Utils.parse_nested_query(request.query_string)

        [*OrganicSitemap.skipped_params].each{|sp| query_string.reject!{|x,_| x[sp]}}

        sanitize_url = request.path
        sanitize_url << "?#{Rack::Utils.build_query(query_string.sort)}" if query_string.any?
        sanitize_url
      rescue => e
        p "ERROR: " + e
        '/'
      end
    end
  end
end
