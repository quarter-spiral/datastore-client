source 'https://rubygems.org'

# Specify your gem's dependencies in datastore-client.gemspec
gemspec

# gem 'service-client', path: '../service-client'
gem 'service-client', git: 'git@github.com:quarter-spiral/service-client.git', :tag => 'release-0.0.3'

group :development, :test do
  # gem 'datastore-backend', path: '../datastore-backend'
  gem 'datastore-backend', git: 'git@github.com:quarter-spiral/datastore-backend.git', tag: 'release-0.0.2'

  gem 'uuid'
  gem 'rack-test'
  gem 'rake'

  platforms :rbx do
    gem 'bson_ext'
  end
end
