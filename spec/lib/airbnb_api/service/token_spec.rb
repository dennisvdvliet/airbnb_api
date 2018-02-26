require 'spec_helper'

describe AirbnbApi::Service::Token do
  let(:client) { AirbnbApi::Client.new(id: 1234, secret: 'topsecret') }
  describe '#create_from_code' do
    it 'should make a POST request' do
      stub = stub_request(:post, 'https://api.airbnb.com/v2/oauth2/authorizations')
             .with(body: { code: 'secret' })
             .to_return(body: response_fixture_for(:token))
      expect(described_class.new(client).create_from_code('secret')).to be_instance_of(AirbnbApi::Resource::Token)
      expect(stub).to have_been_requested
    end
  end

  describe '#refresh_token' do
    it 'makes a POST request for a new token' do
      stub = stub_request(:post, 'https://api.airbnb.com/v2/oauth2/authorizations')
             .with(body: { refresh_token: 'secret-refresh-token' })
             .to_return(body: response_fixture_for(:token))
      described_class.new(client).refresh_token('secret-refresh-token')
      expect(stub).to have_been_requested
    end
  end

  describe '#build' do
    it 'returns a Token resource' do
      expect(described_class.new(client).build(fixture_for(:token))).to be_a(AirbnbApi::Resource::Token)
    end
  end

  describe '#find' do
    it 'should make a GET request' do
      stub = stub_request(:get, 'https://api.airbnb.com/v2/oauth2/authorizations/token')
             .with(headers: { 'Authorization' => 'Basic MTIzNDp0b3BzZWNyZXQ=' })
             .to_return(body: response_fixture_for(:token))
      client.tokens.find('token')
      expect(stub).to have_been_requested
    end
  end
end
