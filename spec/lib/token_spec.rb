require 'rails_helper'

RSpec.describe Token do
  before { freeze_time }
  after { after_teardown }

  describe 'constructer' do
    context 'with no matching client' do
      it 'should blow up with not found' do
        expect { Token.new(client_identifier: 'nothing', client_secret: 'nothing') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'with matching client' do
      it 'should not blow up' do
        client = Client.create(client_identifier: 'client', client_secret: 'secret')

        expect { Token.new(client_identifier: client.client_identifier, client_secret: client.client_secret) }.not_to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#create' do
    it 'should return a jwt token' do
      expiry = 1.hour.from_now.to_i
      client = Client.create(client_identifier: 'client', client_secret: 'secret')
      token = Token.new(client_identifier: 'client', client_secret: 'secret', expiry: expiry)
      jwt_token = token.create

      expect(jwt_token).to be_kind_of(String)
      expect(Base64.decode64(jwt_token.split('.').first)).to eq("{\"alg\":\"HS512\"}")
      expect(Base64.decode64(jwt_token.split('.').second)).to eq("{\"client_identifier\":\"client\",\"exp\":#{expiry}}")
    end
  end

  describe '::decode' do
    it 'should be able to decode a valid token' do
      expiry = 1.hour.from_now.to_i
      client = Client.create(client_identifier: 'client', client_secret: 'secret')
      token = Token.new(client_identifier: 'client', client_secret: 'secret', expiry: expiry)
      jwt_token = token.create

      expect(Token.decode(jwt_token)).to eq([{"client_identifier"=>"client", "exp"=>expiry}, {"alg"=>"HS512"}])
    end

    it 'should throw JWT::VerificationError when token is changed' do
      expiry = 1.hour.from_now.to_i
      client = Client.create(client_identifier: 'client', client_secret: 'secret')
      token = Token.new(client_identifier: 'client', client_secret: 'secret', expiry: expiry)
      jwt_token = token.create + 'aaas'

      expect { Token.decode(jwt_token) }.to raise_error(JWT::VerificationError)
    end

    it 'should throw JWT::ExpiredSignature when token is expired' do
      expiry = Time.now.to_i - 1
      client = Client.create(client_identifier: 'client', client_secret: 'secret')
      token = Token.new(client_identifier: 'client', client_secret: 'secret', expiry: expiry)
      jwt_token = token.create

      expect { Token.decode(jwt_token) }.to raise_error(JWT::ExpiredSignature)
    end
  end
end