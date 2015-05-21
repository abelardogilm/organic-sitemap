require 'simplecov'
# $: << File.expand_path("../../lib", __FILE__)

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'organic-sitemap'
require 'redis'

SimpleCov.start

require 'fakeredis/rspec'

RSpec.configure do |config|
  config.filter_run_excluding broken: true
end

OrganicSitemap.configure

OK_STATUS_CODES = 200..207
REDIRECT_STATUS_CODES = 300..307
CLIENT_ERROR_STATUS_CODES = 400..429
ERROR_STATUS_CODE = 500..509

ALL_STATUS = [*OK_STATUS_CODES, *REDIRECT_STATUS_CODES, *CLIENT_ERROR_STATUS_CODES, *ERROR_STATUS_CODE]
