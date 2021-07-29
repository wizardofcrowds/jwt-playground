class Client < ApplicationRecord
  has_secure_password :client_secret, validations: false
end
