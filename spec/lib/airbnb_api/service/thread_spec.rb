require 'spec_helper'

describe AirbnbApi::Service::Thread do
  let(:client) { AirbnbApi::Client.new(id: '1234', oauth_token: 'awesome_secret') }
  describe 'default parameter' do
    it 'expects the _format parameter to be set' do
      expect(AirbnbApi::Service::Thread.parameters).to have_key(:_format)
      expect(AirbnbApi::Service::Thread.parameters[:_format]).to eq('for_api_partners')
    end
  end

  describe '#find' do
    it 'should make a request to /threads/100' do
      stub = stub_request(:get, 'https://api.airbnb.com/v2/threads/100')
             .with(query: hash_including(:_format))
             .to_return(body: response_fixture_for(:thread))
      response = described_class.new(client).find(100)
      expect(stub).to have_been_requested
      expect(response).to be_instance_of(AirbnbApi::Resource::Thread)
    end
  end
end
