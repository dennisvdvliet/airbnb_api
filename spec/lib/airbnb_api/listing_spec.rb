require 'spec_helper'

describe AirbnbApi::Listing do
  it 'should respond to .find' do
    expect(AirbnbApi::Listing).to respond_to(:find)
  end

  it 'should have listings as API path' do
    expect(AirbnbApi::Listing.resource_url).to eq('/listings')
  end

  context 'when used from the AirbnbApi::Client' do
    let(:client) { AirbnbApi::Client.new(id: 1234, secret: 'topsecret') }
    it 'makes a request to find a listing' do
      stub = stub_request(:get, '/v2/listings/12')
      client.listings.find(12)
      expect(stub).to have_been_requested
    end
  end
end
