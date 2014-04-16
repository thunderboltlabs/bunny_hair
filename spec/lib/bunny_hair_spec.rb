require 'spec_helper'

describe BunnyHair do
  describe '.new' do
    it 'returns a connection object' do
      instance = BunnyHair.new
      expect(instance).to be_kind_of BunnyHair::Connection
    end
  end
end