require "datastore-client/version"

require "service-client"

module Datastore
  class Client
    API_VERSION = 'v1'

    attr_reader :client

    def initialize(url)
      @client = Service::Client.new(url)
      @client.urls.add(:data_set, :post, "/#{API_VERSION}/:scope:/:uuid:")
      @client.urls.add(:data_set, :get,  "/#{API_VERSION}/:scope:/:uuid:")
      @client.urls.add(:data_set, :put,  "/#{API_VERSION}/:scope:/:uuid:")
    end

    def get(scope, uuid)
      response = begin
        @client.get(@client.urls.data_set(scope: scope, uuid: uuid))
      rescue Service::Client::ServiceError => e
        return nil if not_found?(e)
        raise e
      end
      response.data
    end

    def set(scope, uuid, data_set)
      url = @client.urls.data_set(scope: scope, uuid: uuid)
      response = begin
        @client.put(url, data_set)
      rescue Service::Client::ServiceError => e
        if not_found?(e)
          @client.post(url, data_set)
        else
          raise e
        end
      end
      response.data
    end

    protected
    def not_found?(service_error)
      service_error.error == "Not found"
    end
  end
end
