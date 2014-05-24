module BunnyHair
  class Channel
    attr_reader :connection, :test_queues, :test_exchanges

    def initialize(connection=BunnyHair.new)
      @connection = connection
      @test_queues = []
      @test_exchanges = []
    end

    def queue(name, options={})
      if queue = @test_queues.select {|q| q.name == name }[0]
        return queue
      end

      Queue.new(name, options).tap do |queue|
        @test_queues << queue
      end
    end

    def topic(name, options={})
      exchange_factory(name, :topic, options)
    end

    def fanout(name, options={})
      exchange_factory(name, :fanout, options)
    end

    def direct(name, options={})
      exchange_factory(name, :direct, options)
    end

    def ack(*args)
    end
    alias acknowledge ack

    private

    def exchange_factory(name, type, options={})
      if exchange = @test_exchanges.select {|e| e.name == name }[0]
        return exchange
      end

      Exchange.new(connection, type, name, options).tap do |ex|
        @test_exchanges << ex
      end
    end
  end
end