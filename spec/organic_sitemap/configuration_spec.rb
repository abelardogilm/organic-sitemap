require 'spec_helper'

describe "OrganicSitemap#Configuration" do
  {'storage' => {
      default:   'redis',
      new_value: 'text'
    },
    'storage_key' => {
      default:   'sitemap-urls',
      new_value: 'sitemap'
    },
    'domains' => {
      default:   nil,
      new_value: 'test.com'
    },
    'allowed_params' => {
      default:   [],
      new_value: ['test']
    },
    'skipped_urls' => {
      default:   [],
      new_value: ['/test']
    },
    'expiry_time' => {
      default:   7,
      new_value: 1
    },
    'crawler_domain' => {
      default:   nil,
      new_value: "http://test.com"
    },
    'crawler_delay' => {
      default:   nil,
      new_value: 1
    },
    'clean_redirects' => {
      default:   false,
      new_value: true
    },
    'clean_not_found' => {
      default:   false,
      new_value: true
    }
  }.each do |prop, values|
    describe "PROP: #{prop}" do
      after do
        OrganicSitemap.configuration.send("#{prop}=", values[:default])
      end

      it 'has default configuration' do
        expect(OrganicSitemap.configuration.send(prop)).to eq(values[:default])
      end
      it 'can redefine storage value' do
        OrganicSitemap.configuration.send("#{prop}=",  values[:new_value])
        expect(OrganicSitemap.configuration.send(prop)).to eq(values[:new_value])
      end
    end
  end
end
