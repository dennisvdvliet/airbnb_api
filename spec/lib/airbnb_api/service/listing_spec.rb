require 'spec_helper'

describe AirbnbApi::Service::Listing do
  let(:client) { AirbnbApi::Client.new(id: '1234', secret: 'topsecret', oauth_token: 'awesome_secret') }
  describe '#find' do
    it 'should respond to .find' do
      expect(described_class.new(client)).to respond_to(:find)
    end

    it 'should make a request to /listings/1' do
      stub = stub_request(:get, 'https://api.airbnb.com/v2/listings/1')
             .to_return(body: response_fixture_for(:listing))
      described_class.new(client).find(1)
      expect(stub).to have_been_requested
    end
  end

  describe '#create' do
    it 'makes a POST request to create listing' do
      stub = stub_request(:post, 'https://api.airbnb.com/v2/listings')
             .with(body: { name: 'listing name' })
             .with(headers: { 'X-Airbnb-Oauth-Token' => /./ })
             .to_return(body: response_fixture_for(:listing))
      expect(c= client.listings.create(name: 'listing name')).to be_instance_of(AirbnbApi::Resource::Listing)
      expect(stub).to have_been_requested
      puts c.name
    end
  end
end
