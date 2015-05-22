require 'simplecov'
# $: << File.expand_path("../../lib", __FILE__)

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'organic-sitemap'
require 'redis'

SimpleCov.start

require 'fakeredis/rspec'

RSpec.configure do |config|
  config.filter_run_excluding broken: true
  config.before(:all) do
    OrganicSitemap.configure
  end
end

OK_STATUS_CODES = 200..207
REDIRECT_STATUS_CODES = 300..307
CLIENT_ERROR_STATUS_CODES = 400..429
ERROR_STATUS_CODE = 500..509

ALL_STATUS = [*OK_STATUS_CODES, *REDIRECT_STATUS_CODES, *CLIENT_ERROR_STATUS_CODES, *ERROR_STATUS_CODE]

CONTENT_TYPE_VALUES = [ 
  {'Content-Type' => 'audio/basic'},
  {'Content-Type' => 'video/msvideo, video/avi, video/x-msvideo'},
  {'Content-Type' => 'image/bmp'},
  {'Content-Type' => 'application/x-bzip2'},
  {'Content-Type' => 'text/css'},
  {'Content-Type' => 'application/xml-dtd'},
  {'Content-Type' => 'application/msword'},
  {'Content-Type' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'},
  {'Content-Type' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.template'},
  {'Content-Type' => 'application/ecmascript'},
  {'Content-Type' => 'application/octet-stream'},
  {'Content-Type' => 'image/gif'},
  {'Content-Type' => 'application/x-gzip'},
  {'Content-Type' => 'application/mac-binhex40'},
  {'Content-Type' => 'text/html'},
  {'Content-Type' => 'application/java-archive'},
  {'Content-Type' => 'image/jpeg'},
  {'Content-Type' => 'application/x-javascript'},
  {'Content-Type' => 'audio/x-midi'},
  {'Content-Type' => 'audio/mpeg'},
  {'Content-Type' => 'video/mpeg'},
  {'Content-Type' => 'audio/vorbis, application/ogg'},
  {'Content-Type' => 'application/pdf'},
  {'Content-Type' => 'application/x-perl'},
  {'Content-Type' => 'image/png'},
  {'Content-Type' => 'application/vnd.openxmlformats-officedocument.presentationml.template'},
  {'Content-Type' => 'application/vnd.openxmlformats-officedocument.presentationml.slideshow'},
  {'Content-Type' => 'application/vnd.ms-powerpointtd>'},
  {'Content-Type' => 'application/vnd.openxmlformats-officedocument.presentationml.presentation'},
  {'Content-Type' => 'application/postscript'},
  {'Content-Type' => 'video/quicktime'},
  {'Content-Type' => 'audio/x-pn-realaudio, audio/vnd.rn-realaudio'},
  {'Content-Type' => 'audio/x-pn-realaudio, audio/vnd.rn-realaudio'},
  {'Content-Type' => 'application/rdf, application/rdf+xml'},
  {'Content-Type' => 'application/rtf'},
  {'Content-Type' => 'text/sgml'},
  {'Content-Type' => 'application/x-stuffit'},
  {'Content-Type' => 'application/vnd.openxmlformats-officedocument.presentationml.slide'},
  {'Content-Type' => 'image/svg+xml'},
  {'Content-Type' => 'application/x-shockwave-flash'},
  {'Content-Type' => 'application/x-tar'},
  {'Content-Type' => 'application/x-tar'},
  {'Content-Type' => 'image/tiff'},
  {'Content-Type' => 'text/tab-separated-values'},
  {'Content-Type' => 'text/plain'},
  {'Content-Type' => 'audio/wav, audio/x-wav'},
  {'Content-Type' => 'application/vnd.ms-excel.addin.macroEnabled.12'},
  {'Content-Type' => 'application/vnd.ms-excel'},
  {'Content-Type' => 'application/vnd.ms-excel.sheet.binary.macroEnabled.12'},
  {'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'},
  {'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.template'},
  {'Content-Type' => 'application/zip, application/x-compressed-zip'},
  {'Content-Type' => 'application/xml'}
]
