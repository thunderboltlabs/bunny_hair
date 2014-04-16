module BunnyHair
  class Channel
    attr_reader :connection

    def initialize(connection=BunnyHair.new)
      @connection = connection
    end

    def queue(name, options={})
      Queue.new(name, options)
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