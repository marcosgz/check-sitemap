require 'fileutils'
require 'open-uri'
require 'zlib'
require 'nokogiri'
require 'timeout'
require 'uri'
require 'rainbow'
require 'openssl'

require 'check_sitemap/version'
require 'check_sitemap/errors'

module CheckSitemap

  autoload 'XMLReader',     'check_sitemap/xml_reader'
  autoload 'CommandLine',   'check_sitemap/command_line'
  autoload 'Config',        'check_sitemap/config'
  autoload 'CheckURL',      'check_sitemap/check_url'

  def config
    @config ||= Config.new
  end

  def log(msg)
    puts(msg) if config.verbose?
  end

  extend self
end
