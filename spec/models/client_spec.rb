require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'client_secret handling' do
    it 'should persist client_secret_digetst' do
      client = Client.new(client_identifier: 'identifier')
      client.client_secret = 'abc'
      client.save!

      expect(client.client_secret_digest).not_to be_nil
    end

    it 'should authenticate by client_secret' do
      client = Client.create(client_identifier: 'identifier',
                             client_secret: 'abc')

      expect(client.authenticate_client_secret('abc')).to be_truthy
      expect(client.authenticate_client_secret('xyz')).to be_falsy
    end

  end
end
