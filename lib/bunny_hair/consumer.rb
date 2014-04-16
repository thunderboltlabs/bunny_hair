module BunnyHair
  class Consumer

    # This interface has been stolen from Bunny itself
    # https://github.com/ruby-amqp/bunny/blob/master/lib/bunny/consumer.rb
    # specific commit: https://github.com/ruby-amqp/bunny/blob/f7844397ffcb1ef8b7a377c59335a154a6adfc26/lib/bunny/consumer.rb
    attr_reader   :queue
    attr_accessor :consumer_tag
    attr_reader   :arguments
    attr_reader   :no_ack
    attr_reader   :exclusive

    def initialize(queue)
      @queue = queue || raise(ArgumentError, "queue is nil")

      self.queue.consumers << self
    end

    def on_delivery(&block)
      @on_delivery = block
      self
    end

    def cancel
      queue.consumers.delete(self)
    end

    def call(*args)
      @on_delivery.call(*args) if @on_delivery
    end
    alias handle_delivery call
  end
end