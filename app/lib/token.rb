class Token
  def initialize(client_identifier:, client_secret:, expiry: 2.hours.from_now.to_i)
    @client_identifier = client_identifier
    @client_secret = client_secret
    @expiry = expiry
    @client = Client.find_by!(client_identifier: client_identifier)
  end

  def create
    if @client.authenticate_client_secret(@client_secret)
      payload = { client_identifier: @client_identifier, exp: @expiry }
      JWT.encode payload, Token.secret_token, Token.hash_algorithm
    end
  end

  class << self
    def secret_token
      Rails.application.secrets.secret_key_base.to_s
    end

    def hash_algorithm
      'HS512'
    end

    def decode(jwt_token)
      JWT.decode jwt_token, secret_token, true, { algorithm: hash_algorithm }
    end
  end
end
