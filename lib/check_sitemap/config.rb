class CheckSitemap::Config
  attr_writer :verbose, :num_threads, :timeout, :adapter

  def verbose?
    !!@verbose
  end

  def num_threads
    @num_threads ||= 1
  end

  def timeout
    @timeout ||= 30
  end

  def adapter
    @adapter ||= CheckSitemap::CheckURL
  end

end
