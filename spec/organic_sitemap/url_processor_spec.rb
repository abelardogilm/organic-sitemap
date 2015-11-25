# require 'spec_helper'
# require 'rack'
# require './lib/organic-sitemap/middleware/url_capture'
# require 'pry'

# describe OrganicSitemap::UrlProcessor do
#   let(:app) { proc{[status, headers, body]} }
#   let(:stack) { OrganicSitemap::Middleware::UrlCapture.new(app) }
#   let(:request) { Rack::MockRequest.new(stack) }

#   context "when called with a POST request" do
#     let(:status) { 200 }
#     let(:headers) { {'Content-Type' => 'text/html'} }
#     let(:body) { ['OK'] }
#     let(:response) { request.post('/') }
#     let(:subject) { OrganicSitemap::UrlProcessor.new(status, headers, request) }

#     context "with some particular data" do
#       it "passes the request through unchanged" do
#         expect(response.headers['CONTENT_TYPE']).to eq('text/html')
#         expect(app['CONTENT_LENGTH']).to eq(post_data.length)
#         expect(app.request_body).to eq(post_data)
#       end
#     end
#   end
# end

# # describe OrganicSearch::Middleware::UrlCapture do
# #   # 
# #   # subject { described_class.new(app) }

# #   # context "when called with a POST request" do
# #   #   let(:request) { Rack::MockRequest.new(app) }
# #   #   before(:each) do
# #   #     request.post("/", input: post_data, 'CONTENT_TYPE' => 'text/plain')
# #   #   end

# #   #   context "with some particular data" do
# #   #     let(:post_data) { "String or IO post data" }

# #   #     it "passes the request through unchanged" do
# #   #       expect(app['CONTENT_TYPE']).to eq('text/html')
# #   #       expect(app['CONTENT_LENGTH']).to eq(post_data.length)
# #   #       expect(app.request_body).to eq(post_data)
# #   #     end
# #   #   end
# #   # end
# # end

