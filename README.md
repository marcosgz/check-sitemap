# Check Sitemap

`check-sitemap` is agem that pulls a sitemap and checks all of the URLs listed in it.

## Installation

    $ gem install check-sitemap

## Usage


    $ checksitemap <location> [options]

Remote url:

    $ checksitemap http://example.com/sitemap.xml

Local filename:

    $ checksitemap path/to/sitemap.xml.gz # Yeah.. works also with gziped files(Remote or local)


It process all the files included in the sitemap index. Use `--concurrence=<num threads>` to parallel process sitemap urls.

    $ checksitemap http://example.com/sitemap_index.xml --concurrence=5


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcosgz/check-sitemap.