module AirbnbApi
  module Resource
    class Token
      include AirbnbApi::Resource
      extend AirbnbApi::Resource::ClassMethods

      attributes %i[
        access_token
        expires_at
        refresh_token
        user_id
      ]
    end
  end
end
