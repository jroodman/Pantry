class AlexaController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_alexa_authenticity

  def main
    verify_alexa_authenticity
    requestHandler = Pantry::Handlers::AlexaRequestHandler.new params
    render json: requestHandler.process
  end

  private

  def verify_alexa_authenticity
    verifier = AlexaVerifier.new
    verifier.verify!(
      request.headers['SignatureCertChainUrl'],
      request.headers['Signature'],
      request.body.read
    )
  end

end
