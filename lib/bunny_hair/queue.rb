module BunnyHair
  class Queue
    attr_reader :name, :options, :message_count, :exchange, :messages

    def initialize(name, options={})
      @name = name
      @options = options
      @message_count = 0
    	@messages ||= []
    end

    def consumers
      @consumers ||= []
    end

    def bind(exchange, options={})
      @exchange = exchange
      exchange.queues << self
    end

    def delete
			@exchange.queues.delete_if { |q| q.name == name }
    end

    def pop
			@messages.pop
    end

    def subscribe(opts = {}, &block)
      consumer = Consumer.new(self)
      consumer.on_delivery(&block)

      consumer
    end

    def receive(metadata, info, payload)
      metadata ||= OpenStruct.new
      info ||= OpenStruct.new

      @messages << [metadata, info, payload]
      @message_count += 1

      consumers.each do |subscription|
        subscription.call(info, metadata, payload)
      end
    end

    def publish(payload)
      receive(nil, nil, payload)
    end

    def auto_delete?
      !!options[:auto_delete]
    end
  end
end
