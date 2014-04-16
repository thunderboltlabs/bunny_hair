require 'spec_helper'

describe BunnyHair::Consumer do
  describe '#cancel' do
    let(:queue) { BunnyHair::Queue.new('queue.name') }
    subject(:consumer) { BunnyHair::Consumer.new(queue) }

    it 'removes itself from the queues list of consumers' do
      queue.consumers << consumer

      consumer.cancel

      expect(queue.consumers).to_not include(consumer)
    end
  end
end