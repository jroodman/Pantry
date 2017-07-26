require 'rails_helper'

RSpec.describe Handlers::IntentRequestHandlers::TransactionIntentRequestHandler do

  describe ".process" do

    let!(:user) { User.create(amazon_user_id: 'sample_user_id') }

    context 'when initialized with a context containing a GetExpiration Intent' do
      let(:intent) do
        {
          'name' => 'GetExpiration',
          'slots' => {
            'item' => {
              'name' => 'item',
              'value' => 'oranges'
            }
          }
        }
      end

      let(:context) { double('Context', user_id: user.id, intent: intent, dialog_state: nil) }

      subject { Handlers::IntentRequestHandlers::InformationIntentRequestHandler.new(context) }

      it "correctly returns an appropriate JSON response" do
        response = JSON.parse subject.process

        expect(response['version']).to eq '1.0'
        expect(response['response']['outputSpeech']['text']).to eq 'When appropriately stored, oranges is good for 42 days'
        expect(response['response']['card']['title']).to eq 'oranges'
        expect(response['response']['card']['content']).to eq 'When appropriately stored, oranges is good for 42 days'
        expect(response['response']['reprompt']['outputSpeech']['text']).to eq 'Is there anything else I can help you with?'
      end
    end

  end

end
