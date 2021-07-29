class TokensController < ApplicationController
  def create
    if token = Token.new(client_identifier: params[:client_identifier],
                         client_secret: params[:client_secret]).create
      render plain: token, status: :created
    else
      render :none, status: :unauthorized
    end
  end

  private
    def token_params
      params.require(:client_identifier, :client_secret)
    end
end
