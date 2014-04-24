module BunnyHair
  class Channel
    attr_reader :connection, :test_queues

    def initialize(connection=BunnyHair.new)
      @connection = connection
      @test_queues = []
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
      Exchange.new(connection, :topic, name, options)
    end

    def fanout(name, options={})
      Exchange.new(connection, :fanout, name, options)
    end

    def direct(name, options={})
      Exchange.new(connection, :direct, name, options)
    end

    def ack(*args)
    end
    alias acknowledge ack
  end
end