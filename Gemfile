source 'https://rubygems.org'
source "https://user:#{ENV['QS_GEMS_PASSWORD']}@privategems.herokuapp.com/"

# Specify your gem's dependencies in datastore-client.gemspec
gemspec

# gem 'service-client', path: '../service-client'

group :development, :test do
  #gem 'datastore-backend', path: '../datastore-backend'
  gem 'datastore-backend', '0.0.5'
  gem 'uuid'
  gem 'rack-test'
  gem 'rake'

  platforms :rbx do
    gem 'bson_ext'
  end
end
