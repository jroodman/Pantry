require 'rails_helper'

RSpec.describe Handlers::IntentRequestHandlers::TransactionIntentRequestHandler do

  describe ".process" do

    let!(:user) { User.create(amazon_user_id: 'sample_user_id') }

    context 'when initialized with a context containing an Add Intent' do
      let(:intent) do
        {
          'name' => 'Add',
          'slots' => {
            'item_A' => {
              'name' => 'item_A',
              'value' => '5 oranges'
            },
            'item_B' => {
              'name' => 'item_B',
              'value' => nil
            },
            'item_C' => {
              'name' => 'item_C',
              'value' => nil
            },
            'item_D' => {
              'name' => 'item_D',
              'value' => nil
            },
            'item_E' => {
              'name' => 'item_E',
              'value' => nil
            }
          }
        }
      end

      let(:context) { double('Context', user_id: user.id, intent: intent) }

      subject { Handlers::IntentRequestHandlers::TransactionIntentRequestHandler.new(context) }

      it "correctly returns an appropriate JSON response" do
        response = JSON.parse subject.process

        expect(response['version']).to eq '1.0'
        expect(response['response']['outputSpeech']['text']).to eq '5 oranges were added'
        expect(response['response']['card']['title']).to eq 'Added Food Items'
        expect(response['response']['card']['content']).to eq '5 oranges'
        expect(response['response']['reprompt']['outputSpeech']['text']).to eq 'Is there anything else I can help you with?'
      end
    end

    context 'when initialized with a context containing a Remove Intent' do
      let(:intent) do
        {
          'name' => 'Remove',
          'slots' => {
            'item_A' => {
              'name' => 'item_A',
              'value' => '5 oranges'
            },
            'item_B' => {
              'name' => 'item_B',
              'value' => nil
            },
            'item_C' => {
              'name' => 'item_C',
              'value' => nil
            },
            'item_D' => {
              'name' => 'item_D',
              'value' => nil
            },
            'item_E' => {
              'name' => 'item_E',
              'value' => nil
            }
          }
        }
      end

      let(:context) { double('Context', user_id: user.id, intent: intent) }

      subject { Handlers::IntentRequestHandlers::TransactionIntentRequestHandler.new(context) }

      context "without any quantity of the requested item present in the database" do

        it "correctly returns an appropriate JSON response" do
          response = JSON.parse subject.process

          expect(response['version']).to eq '1.0'
          expect(response['response']['outputSpeech']['text']).to eq '0 oranges were removed'
          expect(response['response']['card']['title']).to eq 'Removed Food Items'
          expect(response['response']['card']['content']).to eq 'oranges not found, 0 removed'
          expect(response['response']['reprompt']['outputSpeech']['text']).to eq 'Is there anything else I can help you with?'
        end

      end

      context "with the requested item present in the database" do

        let!(:item) do
          Item.create(
            name: 'oranges',
            category_small: :citrus,
            category_large: :fruit,
            quantity: 5,
            warning_date: Time.now + 1500,
            expiration_date: Time.now + 1700,
            user_id: user.id
          )
        end

        it "correctly returns an appropriate JSON response" do
          response = JSON.parse subject.process

          expect(response['version']).to eq '1.0'
          expect(response['response']['outputSpeech']['text']).to eq '5 oranges were removed'
          expect(response['response']['card']['title']).to eq 'Removed Food Items'
          expect(response['response']['card']['content']).to eq '5 oranges'
          expect(response['response']['reprompt']['outputSpeech']['text']).to eq 'Is there anything else I can help you with?'
        end

      end
    end

    context 'when initialized with a context containing a Clear Intent' do
      let(:intent) do
        { 'name' => 'Clear' }
      end

      let(:context) { double('Context', user_id: user.id, intent: intent) }

      subject { Handlers::IntentRequestHandlers::TransactionIntentRequestHandler.new(context) }

      context "with some quantity of the requested item present in the database" do

        let!(:item) do
          Item.create(
            name: 'oranges',
            category_small: :citrus,
            category_large: :fruit,
            quantity: 5,
            warning_date: Time.now - 1500,
            expiration_date: Time.now + 1700,
            user_id: user.id
          )
        end

        it "correctly returns an appropriate JSON response" do
          response = JSON.parse subject.process

          expect(response['version']).to eq '1.0'
          expect(response['response']['outputSpeech']['text']).to eq 'All items have been removed'
          expect(response['response']['reprompt']['outputSpeech']['text']).to eq 'Is there anything else I can help you with?'
        end

      end
    end

  end

end
