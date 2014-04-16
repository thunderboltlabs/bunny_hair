require "bunny_hair/version"

module BunnyHair
  autoload :Connection, 'bunny_hair/connection'
  autoload :Exchange, 'bunny_hair/exchange'
  autoload :Channel, 'bunny_hair/channel'
  autoload :Queue, 'bunny_hair/queue'
  autoload :Consumer, 'bunny_hair/consumer'

  def self.new(*)
    Connection.new
  end
end
