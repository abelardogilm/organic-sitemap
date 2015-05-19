require 'simplecov'
# $: << File.expand_path("../../lib", __FILE__)

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'organic-sitemap'
require 'redis'

SimpleCov.start

RSpec.configure do |config|
  config.filter_run_excluding broken: true
end