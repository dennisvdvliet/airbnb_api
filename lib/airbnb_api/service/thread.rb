module AirbnbApi
  module Service
    class Thread
      include AirbnbApi::Service
      extend AirbnbApi::Service::ClassMethods
      include AirbnbApi::APIOperations::Find

      set_path '/threads'
      set_parameter :_format, 'for_api_partners'

      private

      def resource_class
        AirbnbApi::Resource::Thread
      end
    end
  end
end
