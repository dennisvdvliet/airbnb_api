require 'spec_helper'

describe AirbnbApi::Resource::Thread do
  let(:thread) { fixture_for(:thread) }
  describe '.has_many' do
    it 'should return an array for #messages' do
      puts described_class.new(thread).thread
#      expect(described_class.new(thread).messages).to be_a(Array)
    end
  end

end
