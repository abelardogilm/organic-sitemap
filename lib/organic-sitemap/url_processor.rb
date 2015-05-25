module OrganicSitemap
  class UrlProcessor

    attr_accessor :status, :headers, :request

    def initialize(status, headers, request)
      @status, @headers, @request = status, headers, request
    end

    def sanitize_path_info
      query_string = Rack::Utils.parse_nested_query(request.query_string)

      query_string.select!{|x,_| OrganicSitemap.configuration.allowed_params.include? x }

      sanitize_url = request.path
      sanitize_url << "?#{Rack::Utils.build_query(query_string.sort)}" if query_string.any?
      sanitize_url
    rescue => e
      p "OrganicSitemap ERROR: sanitizing #{request.path} raise error"
      p "OrganicSitemap ERROR: " + e
    end

    def sitemap_url?
      success_response? && html_page? && request.get? && is_expected_domain? && is_allowed_url?
    end

    private

    def success_response?
      status == 200
    end

    def html_page?
      headers["Content-Type"]["text/html"]
    end

    def is_expected_domain?
      # Any domain if not explicitly configured
      return true if OrganicSitemap.configuration.domains.nil?
      OrganicSitemap.configuration.domains.include? request.host
    end

    def is_allowed_url?
      # Any url if not explicitly configured
      return true if OrganicSitemap.configuration.skipped_urls.nil?
      [*OrganicSitemap.configuration.skipped_urls].each do |skip_url|
        return false if request.path[skip_url]
      end
      true
    end
  end
end
