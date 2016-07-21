module CheckSitemap
  class Error < StandardError
  end
  class HTTPNotFound < Error
  end
  class FileNotFound < Error
  end
  class InvalidContentType < Error
  end
  class XMLSyntaxError < Error
  end
end
