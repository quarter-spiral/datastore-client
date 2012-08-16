require 'json'

class Datastore::Client::CLI
  def self.get(uuid, scope, host)
    return "You must specify a UUID! Use --help get for more information." unless uuid
    client = Datastore::Client.new(host)
    data = client.get(scope, uuid)
    return "No data stored for #{scope}/#{uuid}" unless data
    JSON.pretty_generate(data)
  end

  def self.set(uuid, json, scope, host)
    data = JSON.parse(json)
    return "You must specify a UUID! Use --help get for more information." unless uuid
    client = Datastore::Client.new(host)
    client.set(scope, uuid, data)
    "Saved:\n" + JSON.pretty_generate(data)
  end

  def self.create(json, scope, host)
    data = JSON.parse(json)
    client = Datastore::Client.new(host)
    uuid = client.create(scope, data)
    "Created:\nUUID: #{uuid}\nData:\n" + JSON.pretty_generate(data)
  end
end
