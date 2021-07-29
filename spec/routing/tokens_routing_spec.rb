require "rails_helper"

RSpec.describe TokensController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/v1/tokens").to route_to("tokens#create")
    end
  end
end
