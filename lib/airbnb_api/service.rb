module AirbnbApi
  module Service
    def initialize(client)
      @client = client
    end

    def build(attributes)
      resource_class.new attributes
    end

    module ClassMethods
      attr_accessor :path
      attr_reader :requires_oauth_token
      def set_path(path)
        @path = path
      end

      def require_oauth_token
        @requires_oauth_token = true
      end

      def can_use_client?(client)
        requires_oauth_token? == client.oauth_token?
      end

      def requires_oauth_token?
        @requires_oauth_token == true
      end

    end
  end
end
