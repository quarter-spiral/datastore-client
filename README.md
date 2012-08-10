# Datastore::Client

Client to the datastore-backend.

## Installation

```
gem install datastore-client
```

## Usage

### Create a client
```ruby
# connect to local
client = DataStore::Client.new('http://datastore-backend.dev')
```

### Retrieve a data set as JSON
```ruby
# private set
client.get(uuid)

# public set
client.get(uuid, scope: :public)
```

### Write a JSON data set
```ruby
data_set = {hello: 'world'}

# write private set
client.set(uuid, data_set)

# write public set
client.set(uuid, data_set, scope: :public)
```

The client will automatically create a set if it the UUID has no set in the given scope yet.