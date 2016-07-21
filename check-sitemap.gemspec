# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'check_sitemap/version'

Gem::Specification.new do |spec|
  spec.name          = "check-sitemap"
  spec.version       = CheckSitemap::VERSION
  spec.authors       = ["Marcos G. Zimmermann"]
  spec.email         = ["mgzmaster@gmail.com"]

  spec.summary       = %q{Check URLs in a sitemap.xml}
  spec.description   = %q{Check URLs in a sitemap.xml}
  spec.homepage      = "https://github.com/marcosgz/check-sitemap"

  spec.executables << 'checksitemap'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
