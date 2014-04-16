require 'spec_helper'

describe BunnyHair::Connection do
  subject(:connection) { BunnyHair::Connection.new }

  describe '#connected?' do
    it 'returns true when start is called' do
      connection.start
      expect(connection).to be_connected
    end

    it 'returns false when started and stopped' do
      connection.start
      connection.stop

      expect(connection).to_not be_connected
    end

    it 'returns false when never stopped' do
      expect(connection).to_not be_connected
    end
  end

  describe '#create_channel' do
    it 'returns a channel' do
      expect(connection.create_channel).to be_kind_of BunnyHair::Channel
    end
  end

  describe '#default_channel' do
    it 'returns a single channel' do
      expect(connection.default_channel).to be_kind_of BunnyHair::Channel
      object_1, object_2 = connection.default_channel, connection.default_channel 
      expect(object_1).to eq object_2
    end
  end
end
