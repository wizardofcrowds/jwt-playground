require 'rails_helper'

RSpec.describe FoursquareClient do
  describe '#connection' do
    it 'should be a HttpClient with keep alive being 15 seconds' do
      connection = FoursquareClient.connection

      expect(connection).to be_kind_of(HTTPClient)
      expect(connection.keep_alive_timeout).to eq(15)
    end
  end
end
