module FoursquareClient
  class VenueSearch
    API_PATH = 'venues/search'.freeze

    attr_reader :query_options
    def initialize(keyword: nil, near:, category_id: nil)
      @query_options = { keyword: keyword, near: near, category_id: category_id }
    end

    def slug
      Digest::SHA256.hexdigest @query_options.inspect
    end

    def execute
      response = connection.get(build_path)
      handle_response(response)
    end

    private

    # Most of the following methods should be extracted to something when adding other Foursquare API supports
    def connection
      FoursquareClient.connection
    end

    def build_path
      FoursquareClient.base_api_endpoint + API_PATH + '?' + query_options.merge(FoursquareClient.default_params).to_query
    end

    def handle_response(response)
      # Throws appropriate exception if the response is non 2XX/3XX.
      handle_error(response)
      JSON.parse response.body
    end

    def error_message(response)
      if response.body.empty?
        "#{response.http_header.request_method} #{response.http_header.request_uri.to_s}: #{response.status}"
      else
        response.body
      end
    end

    def handle_error(response)
      case response.status
      when 400
        raise FoursquareClient::Errors::BadRequest, error_message(response)
      when 401
        raise FoursquareClient::Errors::Unauthorized, error_message(response)
      when 403
        raise FoursquareClient::Errors::Forbidden, error_message(response)
      when 404
        raise FoursquareClient::Errors::NotFound, error_message(response)
      when 405
        raise FoursquareClient::Errors::MethodNotAllowed, error_message(response)
      when 405
        raise FoursquareClient::Errors::Conflict, error_message(response)
      when 500
        raise FoursquareClient::Errors::InternalServerError, error_message(response)
      end
    end
  end
end