require 'rails_helper'

RSpec.describe FoursquareClient do
  before do
    @original_client_id = FoursquareClient.client_id
    @original_client_secret = FoursquareClient.client_secret
    FoursquareClient.client_id = 'client'
    FoursquareClient.client_secret = 'secret'
  end

  after do
    FoursquareClient.client_id = @original_client_id
    FoursquareClient.client_secret = @original_client_secret
  end

  describe '#connection' do
    it 'should be a HttpClient with keep alive being 15 seconds' do
      connection = FoursquareClient.connection

      expect(connection).to be_kind_of(HTTPClient)
      expect(connection.keep_alive_timeout).to eq(15)
    end
  end

  describe FoursquareClient::VenueSearch do
    it 'happy scenario' do
      response_body = load_mock_data('venue_search_response.txt')
      stub_request(:get, 'https://api.foursquare.com/v2/venues/search?category_id=&client_id=client&client_secret=secret&keyword=Totto&near=New%20York,%20NY&v=20210701').
         with(
           headers: {
            'Accept'=>'*/*'
           }).
         to_return(status: 200, body: response_body, headers: {})
      search = FoursquareClient::VenueSearch.new(near: 'New York, NY', keyword: 'Totto')

      expect(search.execute).to eq(JSON.parse response_body)
    end
  end
end
