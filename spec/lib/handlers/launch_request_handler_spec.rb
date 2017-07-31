require 'rails_helper'

RSpec.describe Handlers::LaunchRequestHandler do

  describe ".process" do

    context "Given a context with a user id for which there is an expiring item and an expired item" do

      let!(:user) { User.create(amazon_user_id: 'sample_user_id') }

      let!(:expiring_item) do
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

      let!(:expired_item) do
        Item.create(
          name: 'oranges',
          category_small: :citrus,
          category_large: :fruit,
          quantity: 5,
          warning_date: Time.now - 1500,
          expiration_date: Time.now - 1000,
          user_id: user.id
        )
      end

      let(:context) { double('Context', user_id: user.id) }

      subject { Handlers::LaunchRequestHandler.new(context) }

      it "returns a correctly formatted JSON response, starting a new Alexa session" do
        response = JSON.parse subject.process

        expect(response['version']).to eq '1.0'
        expect(response['response']['outputSpeech']['text']).to eql "Welcome to " +
          "Pantry Keeper. 5 oranges are expired and 5 oranges are expiring soon. Is there anything you would like me to do?"
        expect(response['response']['shouldEndSession']).to eql false
      end

    end

  end

end
