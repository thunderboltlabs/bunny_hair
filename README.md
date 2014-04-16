# BunnyHair

This mock of Bunny is **NOT** complete. It includes common interfaces but does not encompass everything.

Basically it covers:

* Make a channel
* Make an exchange
* Make a queue
* Bind that queue to the exchange
* Subscribe to that queue with a block


## Installation

Add this line to your application's Gemfile:

    gem 'bunny_hair'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bunny_hair

## Usage

To get a great idea of what is actually possible with this gem, take a gander at the [specs](spec/).

### Connections

Typically you'll create a connection in Bunny by simply calling `Bunny.new`, this gem is essentially no different.

	BunnyHair.new # => BunnyHair::Connection.new

You can assume that this object will respond to the methods you actually care about, such as `#start` and `#create_channel`

### Queues

When using queues all publishing will happen immediately. For example...

	connection = BunnyHair.new
	channel = connection.create_channel

	queue = channel.queue('my.queue')

	queue.subscribe do |info, metadata, payload|
		puts payload
	end

	queue.publish('Your payload')

### Exchanges

This gem also supports the creation / usage of exchanges. You can use them normally like you would in Bunny itself.

	channel = connection.create_channel
	topic_exchange = channel.topic('activity.events')

	queue = channel.queue('my.queue', auto_delete: true)

	queue.subscribe do |info, metadata, payload|
		puts payload
	end

	queue.bind(topic_exchange, routing_key: 'activity.events')

	topic_exchange.publish('hello', routing_key: 'activity.events')

	$ => hello

### A note about exchanges

Exchanges in this gem do NOT follow the logic in a normal rabbitmq exchange. For example, you may have a queue with a routing_key set to `activity.#`
If you bind that queue to the exchange, it will not matter what you publish on that exchange, the queue object **WILL** receive it.
If you'd like to see this gem encorporate the logic of the separate exchange types, make a PR =)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# Copyright

See license.txt for details
