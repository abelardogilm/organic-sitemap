module OrganicSitemap
  module Middleware
    class UrlCapture
      def initialize(app)
        @app = app
      end

      def call(env)
        start = Time.now
        status, headers, response = @app.call(env)
        stop = Time.now
        if healty_url(status, headers, response, env)
          p env['HTTP_HOST'] + env['REQUEST_URI']
          p '*' * 100
        end
        [status, headers, response]
      end

      def healty_url(status, headers, response, env)
        success_response(status) && html_page(headers) && get_method?(env)
      end

      def success_response(status)
        status == 200
      end

      def html_page(headers)
        headers["Content-Type"].include? "text/html"
      end

      def get_method?(env)
        env['REQUEST_METHOD'] == 'GET'
      end
    end
  end
end
