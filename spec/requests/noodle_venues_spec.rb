require 'rails_helper'

RSpec.describe "/noodle_venues", type: :request do
  let(:full_valid_attributes) {
    { keyword: 'Totto', near: 'New York, NY', sort: 'distance' }
  }

  let(:minimal_valid_attributes) {
    { near: 'New York, NY' }
  }

  let(:invalid_attributes) {
    { keyword: 'Totto', sort: 'distance' }
  }

  let(:invalid_attributes_in_sort) {
    { keyword: 'Totto', sort: 'blah', near: 'New York, NY' }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /" do
    context "with valid parameters" do
      it "renders a JSON response with the new noodle_venue" do
        builder = instance_double(ResponseBuilder)
        allow(ResponseBuilder).to receive(:new).with({
          "keyword"=>"Totto",
          "near"=>"New York, NY",
          "sort"=>"distance",
          "category_id"=>"55a59bace4b013909087cb24,4bf58dd8d48988d1d1941735,4bf58dd8d48988d149941735,4bf58dd8d48988d14a941735,55a59bace4b013909087cb27"}) \
          .and_return(builder)
        venues = { venues: eval(load_mock_data('venues.txt')) }
        allow(builder).to receive(:build).and_return(venues)

        get noodle_venues_url(full_valid_attributes), headers: valid_headers, as: :json
        expect(response).to have_http_status(:successful)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to eq(venues.to_json)
      end
    end

    context "with minimal valid parameters" do
      it "renders a JSON response with the new noodle_venue" do
        builder = instance_double(ResponseBuilder)
        allow(ResponseBuilder).to receive(:new).with({"category_id"=>"55a59bace4b013909087cb24,4bf58dd8d48988d1d1941735,4bf58dd8d48988d149941735,4bf58dd8d48988d14a941735,55a59bace4b013909087cb27",
          "near"=>"New York, NY"}).and_return(builder)
        venues = { venues: eval(load_mock_data('venues.txt')) }
        allow(builder).to receive(:build).and_return(venues)

        get noodle_venues_url(minimal_valid_attributes), headers: valid_headers, as: :json
        expect(response).to have_http_status(:successful)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to eq(venues.to_json)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors" do
        get noodle_venues_url(invalid_attributes), headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to eq("{\"error\":\"near parameter is required\"}")
      end
    end

    context "with invalid parameters in sort" do
      it "renders a JSON response with errors" do
        get noodle_venues_url(invalid_attributes_in_sort), headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to eq("{\"error\":\"you can set relevance or distance to the sort parameter\"}")
      end
    end

    context "with valid parameters" do
      it "returns an error when the upstream API client blows up with 500" do
        builder = instance_double(ResponseBuilder)
        allow(ResponseBuilder).to receive(:new).with({
          "keyword"=>"Totto",
          "near"=>"New York, NY",
          "sort"=>"distance",
          "category_id"=>"55a59bace4b013909087cb24,4bf58dd8d48988d1d1941735,4bf58dd8d48988d149941735,4bf58dd8d48988d14a941735,55a59bace4b013909087cb27"}) \
          .and_return(builder)
        venues = { venues: eval(load_mock_data('venues.txt')) }
        allow(builder).to receive(:build).and_raise(FoursquareClient::Errors::InternalServerError.new("Sorry, it's Foursquare's fault"))

        get noodle_venues_url(full_valid_attributes), headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to eq("{\"error\":\"Sorry, it's Foursquare's fault\"}")
      end
    end
  end
end
