module AirbnbApi
  module APIOperations
    module Find
      def find(id)
        build @client.get("#{self.class.path}/#{id}")
      end
    end
  end
end
