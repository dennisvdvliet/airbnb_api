require 'base64'

module AirbnbApi
  class Client
    attr_reader :id, :secret, :oauth_token
    def initialize(id:, secret: nil, oauth_token: nil)
      @id = id
      @secret = secret
      @oauth_token = oauth_token
    end

    def version
      @version ||= 'v2'
    end

    def base_url
      'https://api.airbnb.com'
    end

    def adapter
      @adapter ||= Faraday.default_adapter
    end

    def http
      @http ||= Faraday.new(url: base_url) do |faraday|
        faraday.headers = headers
        faraday.request :url_encoded
        faraday.response :json, parser_options: { :symbolize_names => true }

        faraday.use AirbnbApi::Util::ErrorHandling

        faraday.adapter adapter
      end
    end

    %i[get patch post delete].each do |call|
      define_method call do |path, options = {}|
        begin
          http.public_send(call, "#{version}#{path}", options).body
        rescue Faraday::ConnectionFailed => err
          raise AirbnbApi::Errors::Timeout, err
        end
      end
    end

    def oauth_token?
      @oauth_token != nil
    end

    def listings
      AirbnbApi::Service::Listing.new(self)
    end

    def tokens
      return AirbnbApi::Service::Token.new(self) if AirbnbApi::Service::Token.can_use_client?(self)
      raise AirbnbApi::Errors::InvalidClient
    end

    private

    def headers
      default = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      if oauth_token
        default['X-Airbnb-Oauth-Token'] = oauth_token
        default['X-Airbnb-API-Key'] = id
      else
        default['Authorization'] = "Basic #{basic_auth_header}"
      end
      default
    end

    def basic_auth_header
      @basic_auth_header ||= Base64.strict_encode64("#{id}:#{secret}")
    end
  end
end
