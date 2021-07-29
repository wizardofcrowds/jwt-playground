class ResponseBuilder
  attr_reader :venue_search
  delegate :slug, to: :venue_search

  def initialize(query_options={})
    @sort = query_options.delete(:sort) || 'relevance'
    @venue_search = FoursquareClient::VenueSearch.new(keyword: query_options[:keyword],
                                                      near: query_options[:near],
                                                      category_id: query_options[:category_id])
  end

  def build
    response = if (cached = Search.where(slug: slug).where('updated_at > ?', 24.hours.ago).first)
                  cached.upstream_response
               else
                 resp = venue_search.execute
                 Search.find_or_create_by(slug: slug, upstream_response: resp)
                 resp
               end

    venues = response.dig('response', 'venues')
    if @sort == 'distance'
      return { venues: venues.sort{ |a, b| a.dig('location', 'distance') <=> b.dig('location', 'distance') } }
    end

    { venues: venues }
  end
end