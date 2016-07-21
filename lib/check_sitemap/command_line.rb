class CheckSitemap::CommandLine

  def initialize(url_or_filename)
    @url_or_filename = url_or_filename
  end

  def process!
    reader = ::CheckSitemap::XMLReader.new(@url_or_filename)
    if reader.sitemap_index?
      reader.each do |url|
        queue << url
      end
      [].tap do |threads|
        ::CheckSitemap.config.num_threads.to_i.times do
          threads << Thread.new do
            until queue.empty?
              url = queue.pop(true) rescue nil
              if url
                ::CheckSitemap::CommandLine.new(url).process!
              end
            end
          end
        end
      end.each { |t| t.join }
    elsif reader.urlset?
      reader.each do |url|
        ::CheckSitemap.config.adapter.call(url)
      end
    end
  end

  protected

  def queue
    @queue ||= Queue.new
  end
end
