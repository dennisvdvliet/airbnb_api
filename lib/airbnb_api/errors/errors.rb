module AirbnbApi
  module Errors
    class BadRequest < StandardError
    end
    class RateLimit < StandardError
    end
    class InvalidClient < StandardError
    end
  end
end
