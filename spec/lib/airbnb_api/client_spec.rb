require 'spec_helper'

describe AirbnbApi::Client do
  let(:client) { AirbnbApi::Client.new(id: 1234, secret: 'topsecret') }
  context 'without a oauth token' do

    it 'sets id' do
      expect(client.id).to eq(1234)
    end

    it 'sets secret' do
      expect(client.secret).to eq('topsecret')
    end

    describe '#http' do
      it 'returns a faraday connection object' do
        expect(client.http).to be_instance_of Faraday::Connection
      end
      it 'sets the token to the authorization header' do
        expect(client.http.headers['Authorization']).to eq('Basic MTIzNDp0b3BzZWNyZXQ=')
      end
      it 'sets the url to the specified domain' do
        expect(client.http.url_prefix.to_s).to eq('https://api.airbnb.com/')
      end
    end

    describe '#post' do
      it 'posts and parses json' do
        stub_request(:post, 'https://api.airbnb.com/v2/path')
          .to_return(status: 200, body: { foo: 'bar' }.to_json)
        expect(client.post('/path', 'body')).to eq(foo: 'bar')
      end
    end

    describe '#get' do
      it 'gets and parses json' do
        stub_request(:get, 'https://api.airbnb.com/v2/path')
          .to_return(status: 200, body: { foo: 'bar' }.to_json)
        expect(client.get('/path')).to eq(foo: 'bar')
      end
    end

    describe '#patch' do
      it 'patches and parses json' do
        stub_request(:patch, 'https://api.airbnb.com/v2/path')
          .to_return(status: 200, body: { foo: 'bar' }.to_json)
        expect(client.patch('/path', 'body')).to eq(foo: 'bar')
      end
    end

    describe '#delete' do
      it 'deletes and parses json' do
        stub_request(:delete, 'https://api.airbnb.com/v2/path')
          .to_return(status: 200, body: { foo: 'bar' }.to_json)
        expect(client.delete('/path')).to eq(foo: 'bar')
      end
    end
    describe '#token' do
      it 'returns an instance of Token' do
        expect(client.tokens).to be_instance_of(AirbnbApi::Service::Token)
      end
    end
  end

  context 'with a oauth token' do
    let(:client) { AirbnbApi::Client.new(id: 1234, secret: 'topsecret', oauth_token: 'oauth') }
    it 'sets the oauth token' do
      expect(client.oauth_token).to eq('oauth')
    end

    it 'sets the token to the authorization header' do
      expect(client.http.headers['X-Airbnb-Oauth-Token']).to eq('oauth')
      expect(client.http.headers['X-Airbnb-API-Key']).to eq(1234)
    end
    context 'when used with an incompatible resource' do
      it 'raises an error' do
        expect { client.tokens }.to raise_error(AirbnbApi::Errors::InvalidClient)
      end
    end
  end

  describe 'error handling' do
    context 'when hitting an ip rate limit' do
      it 'raises an error' do
        [405, 429, 503].each do |status|
          stub_request(:any, /airbnb/).to_return(status: status)
          expect { client.get('/foo/bar') }.to raise_error(AirbnbApi::Errors::RateLimit)
        end
      end
    end
    context 'when a timeout occurs' do
      it 'raises an error' do
        stub_request(:any, /airbnb/).to_timeout
        expect { client.get('/foo/bar') }.to raise_error(AirbnbApi::Errors::Timeout)
      end
    end
  end
end
