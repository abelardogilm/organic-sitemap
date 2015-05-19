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
    'skipped_params' => {
      default:   [],
      new_value: ['utm']
    },
    'skipped_urls' => {
      default:   [],
      new_value: ['/test']
    },
    'expiry_time' => {
      default:   7,
      new_value: 1
    }
  }.each do |prop, values|
    describe "PROP: #{prop}" do 
      it 'has default configuration' do
        expect(OrganicSitemap.send(prop)).to eq(values[:default])
      end
      it 'can redefine storage value' do
        OrganicSitemap.send("#{prop}=",  values[:new_value])
        expect(OrganicSitemap.send(prop)).to eq(values[:new_value])
      end
    end
  end
end
