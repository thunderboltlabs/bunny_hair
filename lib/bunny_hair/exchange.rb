require 'ostruct'

module BunnyHair
  class Exchange
    attr_reader :name, :options, :connection, :type

    def initialize(connection, type, name, options={})
      @connection = connection
      @name = name
      @type = type
      @options = options
    end

    def queues
      @queues ||= []
    end

    def channel
      Channel.new
    end

    def publish(message, options={})
      queues.each do |queue|
        queue.receive(OpenStruct.new, OpenStruct.new, message)
      end
    end

    def method_missing(method, *args)
      method_name  = method.to_s
      is_predicate = false

      if method_name =~ /^(.*)\?$/
        return !!options[method_name.gsub('?', '').to_sym]
      end

      super
    end
  end
end