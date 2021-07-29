require "rails_helper"

RSpec.describe NoodleVenuesController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/v1/noodle_venues").to route_to("noodle_venues#show")
    end
  end
end
