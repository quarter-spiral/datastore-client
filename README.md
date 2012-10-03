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
# private set
client.get(:private, uuid, token)

# public set
client.get(:public, uuid, token)
```

If there is no data set for that UUID, ``nil`` is returned.

### Write a JSON data set
```ruby
data_set = {hello: 'world'}

# write private set
client.set(:private, uuid, token, data_set)

# write public set
client.set(:public, uuid, token, data_set)
```

The client will automatically create a set if the UUID has no set in the given scope yet.

It is also possible to only update a certain key inside of the data set:

```ruby
data_set = {hello: 'world', bli: {bla: 'blub'}}

# create the set
client.set(:public, uuid, token, data_set)

# now update the thing to read: {hello: 'world', bli: {bla: 'blob'}}
client.set(:public, uuid, token, 'blob', key: 'bli/bla')
```

### Create a new data set

If you want to store data for an entity that does not yet have a UUID
you can do so:

```ruby
data_set = {hello: 'world'}

# create private set
client.create(:private, token, data_set)

# create public set
client.create(:public, token, data_set)
```

**Instead of the data set itself the ``create`` will return the UUID of
the created set.**
