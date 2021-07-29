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
    response = get_response

    venues = response.dig('response', 'venues')
    if @sort == 'distance'
      return { venues: venues.sort{ |a, b| a.dig('location', 'distance') <=> b.dig('location', 'distance') } }
    end

    { venues: venues }
  end

  private

  def get_response
    if (cached = Search.find_by(slug: slug))
      return cache_handling(cached)
    else
      resp = venue_search.execute
      Search.find_or_create_by(slug: slug).tap { |s| s.upstream_response = resp }
      resp
    end
  end

  def cache_handling(cache_record)
    if cache_record.updated_at <= 24.hours.ago
      resp = venue_search.execute
      cache_record.update_attribute(:upstream_response, resp)
    end
    return cache_record.upstream_response
  end
end
