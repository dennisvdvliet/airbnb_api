module AirbnbApi
  module Util
    class ErrorHandling < Faraday::Response::Middleware
      ERROR_MAP = {
        400 => AirbnbApi::Errors::BadRequest,
        401 => true,
        402 => true,
        403 => true,
        404 => true,
        405 => true,
        406 => true,
        422 => true,
        429 => true,
        500 => true
      }.freeze

      def on_complete(response)
        key = response[:status].to_i
        raise ERROR_MAP[key], response if ERROR_MAP.key? key
      end
    end
  end
end
