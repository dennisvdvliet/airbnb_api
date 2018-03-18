module AirbnbApi
  module Resource
    class Token
      include AirbnbApi::Resource
      extend AirbnbApi::Resource::ClassMethods

      has_attributes %i[
        access_token
        expires_at
        refresh_token
        user_id
      ]
      has_root false
    end
  end
end
