module AirbnbApi
  module Resource
    class Thread
      include AirbnbApi::Resource
      extend AirbnbApi::Resource::ClassMethods

      has_attributes %i[
        thread
      ]

      has_many :messages, AirbnbApi::Resource::Message
    end
  end
end
