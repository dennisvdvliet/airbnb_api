module AirbnbApi
  module APIOperations
    module Create
      def create(attributes)
        build @client.post(self.class.path.to_s, attributes.to_json)
      end
    end
  end
end
