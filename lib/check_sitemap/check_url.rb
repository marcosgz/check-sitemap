class CheckSitemap::CheckURL

  def self.call(url)
    uri = URI.parse(url)
    h = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == 'https'
      h.use_ssl = true
      h.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    head = \
      begin
        Timeout::timeout(::CheckSitemap.config.timeout) do
          h.start do |ua|
            ua.head(String(uri.path).empty? ? '/' : uri.path)
          end
        end
      rescue Timeout::Error
        puts "#{Rainbow(url).yellow} => #{Rainbow('timeout').red}"
      rescue => e
        puts "#{Rainbow(url).yellow} => #{Rainbow(e.message).red}"
      end

    case head.code.to_i
    when 301
      puts "#{Rainbow(url).yellow} => redirect to #{Rainbow(head['location']).blue}"
    when 200
      puts "#{Rainbow(url).yellow} => #{Rainbow('OK').green}"
    when 404
      puts "#{Rainbow(url).yellow} => #{Rainbow('Not found').red}"
    else
      puts "#{url} => #{Rainbow(head.code.to_s).indianred}"
    end
  end
end
