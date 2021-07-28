require 'foursquare_client/venue_search'
require 'foursquare_client/errors'

module FoursquareClient
  mattr_accessor :base_api_endpoint
  @@base_api_endpoint = "https://api.foursquare.com/v2/"
  
  # Foursquare client id
  mattr_accessor :client_id
  @@client_id = ENV["FOURSQUARE_CLIENT_ID"]

  # Foursquare client secret
  mattr_accessor :client_secret
  @@client_secret = ENV["FOURSQUARE_CLIENT_SECRET"]
  
  # Foursquare compatible date (they call it v)
  # See https://developer.foursquare.com/docs/places-api/versioning/ for details
  mattr_accessor :compatible_date
  @@compatible_date = '20210701'

  mattr_accessor :keep_alive_timeout
  @@keep_alive_timeout = 15 # connecting to something is very costly, so we keep alive

  mattr_accessor :connect_timeout
  @@connect_timeout = 5 # this is rather small but we would like to blow up early

  def self.connection
    # Defining this at the module level so anybody inside the app can take advantage of keep alive
    @connection ||= HTTPClient.new.tap do |client|
      client.keep_alive_timeout = FoursquareClient.keep_alive_timeout
      client.connect_timeout = FoursquareClient.connect_timeout
    end
  end
end
