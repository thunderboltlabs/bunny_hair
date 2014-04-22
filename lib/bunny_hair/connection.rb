module BunnyHair
  class Connection
    attr_accessor :connected

    def connected?
      !!connected
    end

    def start
      self.connected = true
    end

    def stop
      self.connected = false
    end

    def create_channel
      Channel.new(self)
    end

    def default_channel
      @channel ||= Channel.new(self)
    end
  end
end
