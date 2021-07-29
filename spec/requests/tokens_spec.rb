require 'rails_helper'

RSpec.describe "/v1/tokens", type: :request do
  before do
    Client.create(valid_attributes)
  end

  let(:valid_attributes) {
    { client_identifier: 'client', client_secret: 'secret'}
  }

  let(:invalid_attributes) {
    { client_identifier: 'client', client_secret: 'wrong_secret' }
  }

  let(:valid_headers) {
    {}
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "renders a JSON response with the new token" do
        token = instance_double("Token")
        allow(Token).to receive(:new).and_return(token)
        allow(token).to receive(:create).and_return('hoge.hoge.hoge')
        post tokens_url,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("text/plain"))
        expect(response.body).to eq("hoge.hoge.hoge")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the new token" do
        post tokens_url,
             params: invalid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including("text/plain"))
      end
    end
  end
end
