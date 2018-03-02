module AirbnbApi
  module Errors
    class BadRequest < StandardError
    end
    class RateLimit < StandardError
    end
    class InvalidClient < StandardError
    end
    class Timeout < StandardError
    end
  end
end
