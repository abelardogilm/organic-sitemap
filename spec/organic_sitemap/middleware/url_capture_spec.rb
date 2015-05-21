require 'spec_helper'
require 'rack'
require './lib/organic-sitemap/middleware/url_capture'
require 'pry'

describe OrganicSitemap::Middleware::UrlCapture do
  let(:app) { proc{[status, headers, body]} }
  let(:stack) { OrganicSitemap::Middleware::UrlCapture.new(app) }
  let(:request) { Rack::MockRequest.new(stack) }

  ['post', 'put', 'delete'].each do |method|
    context "when called with a #{method.upcase} request" do
      before do
        request.send(method, '/')
      end
      ALL_STATUS.each do |status|
        context "with response #{status}" do
          let(:status) { status }
          let(:headers) { {'Content-Type' => '_'} }
          let(:body) { ['_'] }
          it "don't add anything to url redis" do
            expect(OrganicSitemap::RedisManager.sitemap_urls).to be_empty
          end
        end
      end
    end
  end

  context "when called with a GET request" do
    before do
      request.get('/')
    end
    (ALL_STATUS - [200]).each do |status|
      context "with response #{status}" do
        let(:status) { status }
        let(:headers) { {'Content-Type' => 'text/html'} }
        let(:body) { ['_'] }
        it "don't add anything to url redis" do
          expect(OrganicSitemap::RedisManager.sitemap_urls).to be_empty
        end
      end
    end
    context "with response 200" do
      let(:status) { 200 }
      let(:headers) { {'Content-Type' => 'text/html'} }
      let(:body) { ['_'] }
      it "don't add anything to url redis" do
        expect(OrganicSitemap::RedisManager.sitemap_urls).not_to be_empty
      end
    end
  end
end
