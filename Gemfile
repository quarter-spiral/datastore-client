source 'https://rubygems.org'
source "https://user:We267RFF7BfwVt4LdqFA@privategems.herokuapp.com/"

# Specify your gem's dependencies in datastore-client.gemspec
gemspec

group :development, :test do
  #gem 'datastore-backend', path: '../datastore-backend'
  gem 'datastore-backend', '~> 0.0.18'

  gem 'rack-client'

  gem 'auth-backend', '~> 0.0.28'
  gem 'sqlite3'
  gem 'sinatra_warden', git: 'https://github.com/quarter-spiral/sinatra_warden.git'
  gem 'songkick-oauth2-provider', git: 'https://github.com/quarter-spiral/oauth2-provider.git'
  gem 'nokogiri'

  gem 'auth-client', '~> 0.0.6'

  gem 'uuid'
  gem 'rack-test'
  gem 'rake'

  platforms :rbx do
    gem 'bson_ext'
  end
end
