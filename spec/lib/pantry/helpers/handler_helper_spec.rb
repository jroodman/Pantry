require 'rails_helper'

RSpec.describe Pantry::Helpers::HandlerHelper do

  describe ".create_response" do
    it "returns a correctly formatted response object" do
      response = Pantry::Helpers::HandlerHelper.create_response(
        message: 'This is a test response',
        session_attributes: { session_attribute_key: :session_attribute_value },
        end_session: false
      )

      expect(JSON.parse(response)['response']['outputSpeech']['text']).to eq 'This is a test response'
      expect(JSON.parse(response)['sessionAttributes']).to include('session_attribute_key' => 'session_attribute_value')
      expect(JSON.parse(response)['response']['shouldEndSession']).to eq false
    end
  end

end
