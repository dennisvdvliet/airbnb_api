module AirbnbApi
  module APIOperations
    module Find
      def find(id)
        @client.get("#{self.class.path}/#{id}")
      end
    end
  end
end
