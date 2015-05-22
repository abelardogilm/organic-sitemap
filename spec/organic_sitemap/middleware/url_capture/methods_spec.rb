require 'spec_helper'
require 'rack'
require './lib/organic-sitemap/middleware/url_capture'
require 'pry'

describe OrganicSitemap::Middleware::UrlCapture do
  let(:app) { proc{[200, {'Content-Type' => 'text/html'}, ['OK']]} }
  let(:stack) { OrganicSitemap::Middleware::UrlCapture.new(app) }
  let(:request) { Rack::MockRequest.new(stack) }

  ['post', 'put', 'delete'].each do |method|
    context "when called with a #{method.upcase} request" do
      before do
        request.send(method, '/')
      end
      context "with response 200 and Content-Type text/html" do
        it "don't add anything to url redis" do
          expect(OrganicSitemap::RedisManager.sitemap_urls).to be_empty
        end
      end
    end
  end

  context "when called with a GET request" do
    before do
      request.get('/')
    end
    context "with response 200" do
      it "don't add anything to url redis" do
        expect(OrganicSitemap::RedisManager.sitemap_urls).not_to be_empty
      end
    end
  end
end
