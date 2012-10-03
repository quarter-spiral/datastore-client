require "datastore-client/version"

require "service-client"

module Datastore
  class Client
    API_VERSION = 'v1'

    attr_reader :client

    def initialize(url)
      @client = Service::Client.new(url)
      @client.urls.add(:data_set,         :post, "/#{API_VERSION}/:scope:/:uuid:")
      @client.urls.add(:data_set,         :get,  "/#{API_VERSION}/:scope:/:uuid:")
      @client.urls.add(:data_set,         :put,  "/#{API_VERSION}/:scope:/:uuid:")
      @client.urls.add(:partial_data_set, :put,  "/#{API_VERSION}/:scope:/:uuid:/:key:")
    end

    def get(scope, uuid, token)
      response = begin
        @client.get(@client.urls.data_set(scope: scope, uuid: uuid), token)
      rescue Service::Client::ServiceError => e
        return nil if not_found?(e)
        raise e
      end
      response.data['data']
    end

    def set(scope, uuid, token, data_set, options = {})
      key = options[:key]
      url = @client.urls.data_set(scope: scope, uuid: uuid)
      response = begin
        if key
          sub_set = {key.split('/').last => data_set}
          @client.put(@client.urls.partial_data_set(scope: scope, uuid: uuid, key: key), token, sub_set)
        else
          @client.put(url, token, data_set)
        end
      rescue Service::Client::ServiceError => e
        if not_found?(e)
          raise Service::Client::Error.new("Can not call set on a non existing UUID with the key option!") if key
          @client.post(url, token, data_set)
        else
          raise e
        end
      end
      response.data['data']
    end

    def create(scope, token, data_set)
      @client.post(@client.urls.data_set(scope: scope), token, data_set).data['uuid']
    end

    protected
    def not_found?(service_error)
      service_error.error == "Not found"
    end
  end
end
