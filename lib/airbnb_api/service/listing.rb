module AirbnbApi
  module Service
    class Listing
      include AirbnbApi::Service
      extend AirbnbApi::Service::ClassMethods
      include AirbnbApi::APIOperations::Find
      include AirbnbApi::APIOperations::Create

      set_path '/listings'
      require_oauth_token

      private

      def resource_class
        AirbnbApi::Resource::Listing
      end
    end
  end
end
