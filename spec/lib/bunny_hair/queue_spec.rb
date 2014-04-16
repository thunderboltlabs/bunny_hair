require 'spec_helper'

describe BunnyHair::Queue do
  let(:channel) { BunnyHair.new.create_channel }
  subject(:queue) { BunnyHair::Queue.new('queue.name') }
  let(:exchange) { BunnyHair::Exchange.new(channel, :direct, 'my.exchange') }

  describe '#consumers' do
    it 'returns an array' do
      expect(queue.consumers).to be_kind_of Array
    end

    it 'returns a memoized array' do
      original = queue.consumers
      expect(original).to be(queue.consumers)
    end
  end

  describe '#bind' do
    it 'attaches the queue to the exchange given' do
      queue.bind(exchange, routing_key: 'hello.world')
      expect(exchange).to have(1).queues
    end
  end

  describe '#subscribe' do
    it 'stores the subscription block' do
      queue.subscribe do |metadata, info, payload|
        "hello"
      end

      expect(queue).to have(1).consumers
    end

    it 'accepts options' do
      expect do
        queue.subscribe(ack: false) do |info, message, payload|
          "hello"
        end
      end.to_not raise_error
    end

    it 'returns a consumer object' do
      consumer = queue.subscribe do |i, m, p|
        "hello"
      end

      expect(consumer).to be_kind_of(BunnyHair::Consumer)
      expect(queue.consumers).to include(consumer)
    end
  end

  describe '#delete' do
		it 'removes queues' do
      queue.bind(exchange, routing_key: 'hello.world')
      queue.delete
      expect(exchange).to have(0).queues
		end
	end

  describe '#pop' do
		it 'gets the last message on the queue' do
			queue.receive({}, {}, 'hello')
			message = queue.pop
			expect(message[2]).to eq 'hello'
		end
  end

  describe '#receive' do
    let(:stunt_devil) { double('un diablo', fall: true) }

    it 'runs all subscriptions with the information' do
      queue.subscribe do |metadata, info, payload|
        stunt_devil.fall(payload)
      end

      queue.receive({}, {}, 'hello')
      expect(stunt_devil).to have_received(:fall).with('hello')
    end
  end

  describe '#publish' do
    let(:service) { double('service', payload: true) }

    it 'accepts a payload' do
      expect { queue.publish('payload') }.to_not raise_error
    end

    it 'calls the subscription with the payload' do
      queue.subscribe do |delivery_info, metadata, payload|
        service.payload(payload)
      end

      queue.publish('payload')
      expect(service).to have_received(:payload).with('payload')
    end
  end

  describe '#message_count' do
    it 'stores how many messages it has received' do
      3.times { queue.receive({}, {}, 'hello') }
      expect(queue.message_count).to be(3)
    end
  end
end
