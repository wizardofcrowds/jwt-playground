class NoodleVenuesController < ApplicationController
  class InvalidParams < StandardError; end
  # Ramen, Noodle House, Thai, Vietnamese, Soba
  CATEGORIES = '55a59bace4b013909087cb24,4bf58dd8d48988d1d1941735,4bf58dd8d48988d149941735,4bf58dd8d48988d14a941735,55a59bace4b013909087cb27'.freeze

  rescue_from InvalidParams, FoursquareClient::Errors::Error do |exception|
    render json: error_message(exception), status: :unprocessable_entity
  end

  before_action :validate_params

  def show
    builder = ResponseBuilder.new(noodle_venue_params.merge(category_id: CATEGORIES).to_h.with_indifferent_access)
    render json: builder.build
  end

  private
    def noodle_venue_params
      params.permit(:keyword, :sort, :near)
    end

    def validate_params
      raise InvalidParams.new('near parameter is required') unless noodle_venue_params.keys.include?('near')
      if (sort = noodle_venue_params['sort']) && !%w[relevance distance].include?(sort)
        raise InvalidParams.new('you can set relevance or distance to the sort parameter')
      end 
    end

    def error_message(exception)
      { error: exception&.message || exception.class.to_s }
    end
end
