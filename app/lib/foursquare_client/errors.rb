module FoursquareClient
  module Errors
    class Error < StandardError; end
    class BadRequest < Error; end
    class Unauthorized < Error; end
    class Forbidden < Error; end
    class NotFound < Error; end
    class MethodNotAllowed < Error; end
    class Conflict < Error; end
    class InternalServerError < Error; end
  end
end