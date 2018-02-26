module AirbnbApi
  module Service
    class Token
      include AirbnbApi::Service
      include AirbnbApi::APIOperations::Create
      include AirbnbApi::APIOperations::Find
      extend AirbnbApi::Service::ClassMethods

      set_path '/oauth2/authorizations'

      def create_from_code(code)
        build @client.post(self.class.path.to_s, { code: code }.to_json)
      end

      def refresh_token(refresh_token)
        build @client.post(self.class.path.to_s, { refresh_token: refresh_token }.to_json)
      end

      private

      def resource_class
        AirbnbApi::Resource::Token
      end
    end
  end
end
