require_relative './spec_helper'
require 'datastore-backend'
require 'tempfile'
require 'uuid'

def create_test_mongo_config
  file = Tempfile.new('mongoconfig.yml')
  file.write "embedded:\n\tdatabase: 'embedded-datastore-backend\n\thost: 'localhost'"
  file.close

  ENV['DATASTORE_BACKEND_MONGOID_CONFIG'] = file.path
end

API_APP = Datastore::Backend::API.new
AUTH_APP = Auth::Backend::App.new(test: true)

module Auth
  class Client
    alias raw_initialize initialize
    def initialize(url, options = {})
      raw_initialize(url, options.merge(adapter: [:rack, AUTH_APP]))
    end
  end
end

require 'auth-backend/test_helpers'
auth_helpers = Auth::Backend::TestHelpers.new(AUTH_APP)
token = auth_helpers.get_token

describe Datastore::Client do
  before do
    create_test_mongo_config

    @client = Datastore::Client.new('http://example.com')

    adapter = Service::Client::Adapter::Faraday.new(adapter: [:rack, API_APP])
    @client.client.raw.adapter = adapter

    @not_existing_uuid = UUID.new.generate
  end

  after do
    file = ENV['DATASTORE_BACKEND_MONGOID_CONFIG']
    File.delete(file) if File.exist?(file)
  end

  it "throws an error for requests with a wrong token" do
    begin
      @client.get(:public, @not_existing_uuid, token.reverse).must_be_nil
      flunk "Should throw an Unauthenticated error!"
    rescue Service::Client::ServiceError => e
      e.error.must_equal("Unauthenticated")
    end
  end

  it "returns nil for not existing data sets" do
    @client.get(:public, @not_existing_uuid, token).must_be_nil
  end

  it "can write data that does not yet exist" do
    data_set = {'some' => 'set', 'yeah' => 'yo'}
    @client.set(:public, @not_existing_uuid, token, data_set).must_equal data_set
    @client.get(:public, @not_existing_uuid, token).must_equal data_set
  end

  it "can create a new set (includes creating a new UUID)" do
    data_set = {'some' => 'set', 'yeah' => 'yo'}
    uuid = @client.create(:public, token, data_set)
    uuid.wont_be_nil
    uuid.empty?.must_equal false
  end

  it "can update data" do
    data_set         = {'some' => 'set', 'yeah' => 'yo', 'yes' => 'ya'}
    updated_data_set = {'some' => 'set', 'yeah' => 'yo2', 'oh' => 'no'}
    @client.set(:public, @not_existing_uuid, token, data_set).must_equal data_set
    @client.set(:public, @not_existing_uuid, token, updated_data_set).must_equal updated_data_set
    @client.get(:public, @not_existing_uuid, token).must_equal updated_data_set
  end

  it "can update data partially" do
    data_set = {'some' => {'cool' => 'set'}}
    updated_data_set = {'some' => {'cool' => 'setty set'}}

    @client.set(:public, @not_existing_uuid, token, data_set)
    @client.set(:public, @not_existing_uuid, token, 'setty set', key: 'some/cool').must_equal updated_data_set
    @client.get(:public, @not_existing_uuid, token).must_equal updated_data_set
  end
end
