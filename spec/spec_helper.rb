ENV['RACK_ENV'] ||= 'test'

Bundler.require

require 'minitest/autorun'

require 'datastore-backend'
require 'auth-backend'
require 'rack/client'

require 'datastore-client'
