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
client = Datastore::Client.new('http://datastore-backend.dev')
```

### Retrieve a data set as JSON
```ruby
client.get(uuid, token)
```

If there is no data set for that UUID, ``nil`` is returned.

### Retrieve multiple data sets as JSON
```ruby
client.get([uuid1, uuid2], token) # => {uuid1 => {"some" => "data"}, uuid2 => {"more" => "data"}}
```

If there is no data set for a UUID it won't show up in the result.

### Write a JSON data set
```ruby
data_set = {hello: 'world'}

client.set(uuid, token, data_set)
```

The client will automatically create a set if the UUID has no set in the given scope yet.

It is also possible to only update a certain key inside of the data set:

```ruby
data_set = {hello: 'world', bli: {bla: 'blub'}}

# create the set
client.set(uuid, token, data_set)

# now update the thing to read: {hello: 'world', bli: {bla: 'blob'}}
client.set(uuid, token, 'blob', key: 'bli/bla')
```