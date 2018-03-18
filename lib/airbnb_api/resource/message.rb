module AirbnbApi
  module Resource
    class Message
      include AirbnbApi::Resource
      extend AirbnbApi::Resource::ClassMethods

      has_attributes %i[
        id
        message
        created_at
        attachment_images
        user_id
      ]
    end
  end
end
