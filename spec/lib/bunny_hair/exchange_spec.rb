require 'spec_helper'

describe BunnyHair::Exchange do
  subject(:exchange) { BunnyHair::Exchange.new(connection, :topic, 'my.exchange', durable: true) }
  let(:connection) { BunnyHair.new }

  describe '#initialize' do
    subject(:exchange) { BunnyHair::Exchange.new(connection, :direct, 'chickens', durable: true) }

    it 'accepts a connection' do
      expect { exchange }.to_not \
        raise_exception
    end

    it 'accepts a type' do
      expect(exchange.type).to be(:direct)
    end

    it 'accepts a name' do
      expect(exchange.name).to eq('chickens')
    end

    it 'accepts options' do
      expect(exchange.options).to eq(durable: true)
    end
  end

  describe '#queues' do
    it 'returns an array' do
      expect(exchange.queues).to be_kind_of Array
    end

    it 'returns a memoized array' do
      original = exchange.queues
      expect(original).to be(exchange.queues)
    end
  end

  describe '#channel' do
    it 'returns a channel' do
      expect(exchange.channel).to be_kind_of BunnyHair::Channel
    end
  end

  describe '#publish' do
    let(:queue) { double('queue', receive: true) }
    before { exchange.queues << queue }

    it 'calls #receive on all queues stored' do
      exchange.publish('hello', {})
      expect(queue).to have_received(:receive).with(instance_of(OpenStruct), instance_of(OpenStruct), 'hello').once
    end
  end

  context 'predicate methods' do
    it { should be_durable }
    it { should_not be_full_of_crap }
  end
end