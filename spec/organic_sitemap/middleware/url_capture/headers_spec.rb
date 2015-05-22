require 'spec_helper'
require 'rack'
require './lib/organic-sitemap/middleware/url_capture'
require 'pry'

describe OrganicSitemap::Middleware::UrlCapture do
  let(:app) { proc{[200, headers, ['OK']]} }
  let(:stack) { OrganicSitemap::Middleware::UrlCapture.new(app) }
  let(:request) { Rack::MockRequest.new(stack) }
    
  context "when called with a GET request with response 200" do
    before do
      request.get('/')
    end

    CONTENT_TYPE_VALUES.each do |headers|
      context "With header #{headers}" do
        let(:headers) { headers }  

        if headers['Content-Type'] == 'text/html'
          it "Add url to redis with headers #{headers}" do
            expect(OrganicSitemap::RedisManager.sitemap_urls).not_to be_empty
            expect(OrganicSitemap::RedisManager.sitemap_urls.include? '/').to eq(true)
          end
        else
          p 'set else'
          it "Don't add url to redis with headers #{headers}" do
            expect(OrganicSitemap::RedisManager.sitemap_urls).to be_empty
          end
        end
      end
    end
  end
end
