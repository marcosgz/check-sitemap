class CheckSitemap::XMLReader
  include Enumerable

  def initialize(filename, options={})
    @url_or_filename = filename
    @options = {}
  end

  def sitemap_index?
    doc.css('sitemapindex > sitemap').any?
  end

  def urlset?
    doc.css('urlset > url').any?
  end

  def each(&block)
    return results.to_enum(:each) unless block_given?

    doc.css('loc').each do |loc|
      block.call loc.content
    end
  end

  protected

  def doc
    @doc ||= begin
      CheckSitemap.log("Reading: '#{ @url_or_filename }'")
      Nokogiri::XML(read_xml) { |config| config.strict }
    rescue Nokogiri::XML::SyntaxError => e
      raise(CheckSitemap::XMLSyntaxError.new(e.message))
    end
  end

  def read_xml
    @xml_file = begin
      if gzip?
        gz=Zlib::GzipReader.new(raw_file)
        gz.read
      elsif xml?
        raw_file.read
      end || raise(CheckSitemap::InvalidContentType.new("File format or MIME type is not supported: '#{mime_type(raw_file)}'"))
    end
  end

  def raw_file
    @raw_file ||= download!
  end

  def gzip?
    File.extname(@url_or_filename) == '.gz'
  end

  def xml?
    File.extname(@url_or_filename) == '.xml'
  end

  def download!
    begin
      CheckSitemap.log("Opening '#{ @url_or_filename }'")
      open(@url_or_filename)
    rescue Errno::ENOENT => e
      raise CheckSitemap::FileNotFound.new("Missing filename '#{@url_or_filename}'")
    rescue OpenURI::HTTPError => e
      raise CheckSitemap::HTTPNotFound.new("HTTP request to '#{@url_or_filename}' failed")
    end
  end

end
