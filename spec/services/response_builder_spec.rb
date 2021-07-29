require 'rails_helper'

RSpec.describe ResponseBuilder do
  describe '#slug' do
    it 'should return slug from VenueSearch' do
      venue_search = instance_double(FoursquareClient::VenueSearch)
      allow(FoursquareClient::VenueSearch).to receive(:new).and_return(venue_search)
      allow(venue_search).to receive(:execute).and_return(JSON.parse(load_mock_data('venue_search_response.txt')))
      allow(venue_search).to receive(:slug).and_return('hogehogehoge')

      builder = ResponseBuilder.new(category_id: nil, keyword: 'Totto', near: 'New York, NY', sort: 'distance')

      expect(builder.slug).to eq('hogehogehoge')
    end
  end

  describe '#build' do
    context 'with the same search cached in Search model' do
      it 'should use cached response from Search model' do
        venue_search = instance_double(FoursquareClient::VenueSearch)
        allow(FoursquareClient::VenueSearch).to receive(:new).and_return(venue_search)
        slug = 'hogehogehoge'
        allow(venue_search).to receive(:slug).and_return(slug)
        search = create(:search, slug: slug, upstream_response: JSON.parse(load_mock_data('venue_search_response.txt')))

        builder = ResponseBuilder.new(category_id: nil, keyword: 'Totto', near: 'New York, NY', sort: 'distance')
        expect(builder.build).to eq(eval(load_mock_data('venues.txt')))
      end
    end

    context 'without the same search cached in Seach model' do
      context 'with distance sort option' do
        it 'should return sorted venue results by distance' do
          venue_search = instance_double(FoursquareClient::VenueSearch)
          allow(FoursquareClient::VenueSearch).to receive(:new).and_return(venue_search)
          allow(venue_search).to receive(:execute).and_return(JSON.parse(load_mock_data('venue_search_response.txt')))
          allow(venue_search).to receive(:slug).and_return('hogehogehoge')

          builder = ResponseBuilder.new(category_id: nil, keyword: 'Totto', near: 'New York, NY', sort: 'distance')
  
          expect(builder.build).to eq(eval(load_mock_data('venues.txt')))
        end
      end

      context 'with relevance sort option' do
        it 'should return sorted venue results by relevance' do
          venue_search = instance_double(FoursquareClient::VenueSearch)
          allow(FoursquareClient::VenueSearch).to receive(:new).and_return(venue_search)
          allow(venue_search).to receive(:execute).and_return(JSON.parse(load_mock_data('venue_search_response.txt')))
          allow(venue_search).to receive(:slug).and_return('hogehogehoge')
          builder = ResponseBuilder.new(category_id: nil, keyword: 'Totto', near: 'New York, NY', sort: 'relevance')

          expect(builder.build).to eq(eval(load_mock_data('venues_by_relevance.txt')))
        end
      end
    end
  end
end
