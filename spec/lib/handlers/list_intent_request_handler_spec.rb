require 'rails_helper'

RSpec.describe Handlers::IntentRequestHandlers::ListIntentRequestHandler do

  describe ".process" do

    let!(:user) { User.create(amazon_user_id: 'sample_user_id') }

    let!(:item1) do
      Item.create(
        name: 'oranges',
        category_small: :citrus,
        category_large: :fruit,
        quantity: 5,
        warning_date: Time.now - 1500,
        expiration_date: Time.now - 1000,
        created_at: Time.now,
        user_id: user.id
      )
    end

    let!(:item2) do
      Item.create(
        name: 'bananas',
        category_small: :fresh,
        category_large: :fruit,
        quantity: 3,
        warning_date: Time.now - 1500,
        expiration_date: Time.now + 1700,
        created_at: Time.now,
        user_id: user.id
      )
    end

    context 'when initialized with a context containing a AllItems Intent' do
      let(:intent) do
        { 'name' => 'AllItems' }
      end

      let(:context) { double('Context', user_id: user.id, intent: intent) }

      subject { Handlers::IntentRequestHandlers::ListIntentRequestHandler.new(context) }

      it "correctly returns an appropriate JSON response" do
        response = JSON.parse subject.process

        expect(response['version']).to eq '1.0'
        expect(response['response']['outputSpeech']['text']).to eq 'You have 5 oranges and 3 bananas in your pantry'
        expect(response['response']['card']['title']).to eq 'Food in your Pantry'
        expect(response['response']['card']['content']).to eq (
          "5 oranges added on #{Time.now.strftime("%a, %B %d")}" +
          "\n3 bananas added on #{Time.now.strftime("%a, %B %d")}"
        )
        expect(response['response']['reprompt']['outputSpeech']['text']).to eq 'Is there anything else I can help you with?'
      end
    end

    context 'when initialized with a context containing a FromCategory Intent' do
      let(:intent) do
        {
          'name' => 'FromCategory',
          'slots' => {
            'category' => {
              'name' => 'category',
              'value' => 'fruit'
            }
          }
        }
      end

      let(:context) { double('Context', user_id: user.id, intent: intent) }

      subject { Handlers::IntentRequestHandlers::ListIntentRequestHandler.new(context) }

      it "correctly returns an appropriate JSON response" do
        response = JSON.parse subject.process

        expect(response['version']).to eq '1.0'
        expect(response['response']['outputSpeech']['text']).to eq 'You have 5 oranges and 3 bananas'
        expect(response['response']['card']['title']).to eq 'Food in the Fruit Category'
        expect(response['response']['card']['content']).to eq (
          "5 oranges added on #{Time.now.strftime("%a, %B %d")}" +
          "\n3 bananas added on #{Time.now.strftime("%a, %B %d")}"
        )
        expect(response['response']['reprompt']['outputSpeech']['text']).to eq 'Is there anything else I can help you with?'
      end
    end

    context 'when initialized with a context containing a Warning Intent' do
      let(:intent) do
        { 'name' => 'Warning' }
      end

      let(:context) { double('Context', user_id: user.id, intent: intent) }

      subject { Handlers::IntentRequestHandlers::ListIntentRequestHandler.new(context) }

      it "correctly returns an appropriate JSON response" do
        response = JSON.parse subject.process

        expect(response['version']).to eq '1.0'
        expect(response['response']['outputSpeech']['text']).to eq '3 bananas are expiring soon'
        expect(response['response']['card']['title']).to eq 'Food Expiring Soon'
        expect(response['response']['card']['content']).to eq "3 bananas added on #{Time.now.strftime("%a, %B %d")}"
        expect(response['response']['reprompt']['outputSpeech']['text']).to eq 'Is there anything else I can help you with?'
      end
    end

    context 'when initialized with a context containing an Expired Intent' do
      let(:intent) do
        { 'name' => 'Expired' }
      end

      let(:context) { double('Context', user_id: user.id, intent: intent) }

      subject { Handlers::IntentRequestHandlers::ListIntentRequestHandler.new(context) }

      it "correctly returns an appropriate JSON response" do
        response = JSON.parse subject.process

        expect(response['version']).to eq '1.0'
        expect(response['response']['outputSpeech']['text']).to eq '5 oranges are expired'
        expect(response['response']['card']['title']).to eq 'Expired Food'
        expect(response['response']['card']['content']).to eq "5 oranges added on #{Time.now.strftime("%a, %B %d")}"
        expect(response['response']['reprompt']['outputSpeech']['text']).to eq 'Is there anything else I can help you with?'
      end
    end

  end

end
