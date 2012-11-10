# -*- encoding: utf-8 -*-
require File.expand_path('../lib/datastore-client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Thorben Schröder"]
  gem.email         = ["info@thorbenschroeder.de"]
  gem.description   = %q{Client to the datastore-backend.}
  gem.summary       = %q{Client to the datastore-backend.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "datastore-client"
  gem.require_paths = ["lib"]
  gem.version       = Datastore::Client::VERSION

  gem.add_dependency 'json'
  gem.add_dependency 'service-client', '>=0.0.7'
  gem.add_dependency 'commander'
end
