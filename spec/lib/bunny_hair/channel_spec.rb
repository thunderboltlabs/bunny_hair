require 'spec_helper'

describe BunnyHair::Channel do
  subject(:channel) { BunnyHair::Channel.new }
  let(:connection) { BunnyHair.new }

  describe '#initialize' do
    it 'accepts a connection' do
      instance = described_class.new(connection)
      expect(instance.connection).to be(connection)
    end
  end

  describe '#queue' do
    it 'returns a queue' do
      expect(channel.queue('queue')).to be_kind_of(BunnyHair::Queue)
    end

    it 'returns a queue with a name' do
      queue = channel.queue('my name')
      expect(queue.name).to eq('my name')
    end

    it 'returns a queue with the options set' do
      options = { auto_delete: true }
      queue = channel.queue('queue', options)
      expect(queue.options).to eq(options)
    end
  end

  describe '#topic' do
    it 'returns a topic exchange' do
      exchange = channel.topic('my.topic.exchange', durable: true)
      expect(exchange.name).to eq('my.topic.exchange')
      expect(exchange.type).to be(:topic)
      expect(exchange).to be_durable
    end
  end

  describe '#fanout' do
    it 'returns a fanout exchange' do
      exchange = channel.fanout('my.fanout.exchange', durable: true)
      expect(exchange.name).to eq('my.fanout.exchange')
      expect(exchange.type).to be(:fanout)
      expect(exchange).to be_durable
    end
  end

  describe '#direct' do
    it 'returns a direct exchange' do
      exchange = channel.direct('my.direct.exchange', durable: true)
      expect(exchange.name).to eq('my.direct.exchange')
      expect(exchange.type).to be(:direct)
      expect(exchange).to be_durable
    end
  end

  describe '#ack' do
    it { should respond_to :ack }
  end
end