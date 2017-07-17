require 'rails_helper'

RSpec.describe Pantry::Helpers::HandlerHelper do

  describe ".create_response" do
    it "returns a correctly formatted response object" do
      response = Pantry::Helpers::HandlerHelper.create_response(
        message: 'This is a test response',
        card: {
          type: 'Simple',
          title: 'Title',
          content: 'Content!'
        },
        session_attributes: { session_attribute_key: :session_attribute_value },
        reprompt: 'Sample reprompt',
        end_session: false
      )

      expect(JSON.parse(response)['response']['outputSpeech']['text']).to eq 'This is a test response'
      expect(JSON.parse(response)['sessionAttributes']).to include('session_attribute_key' => 'session_attribute_value')
      expect(JSON.parse(response)['response']['shouldEndSession']).to eq false
      expect(JSON.parse(response)['response']['card']['type']).to eq 'Simple'
      expect(JSON.parse(response)['response']['card']['title']).to eq 'Title'
      expect(JSON.parse(response)['response']['card']['content']).to eq 'Content!'
      expect(JSON.parse(response)['response']['reprompt']['outputSpeech']['text']).to eq 'Sample reprompt'
    end
  end

  let!(:items) do
    items = []
    items << Item.create(
      name: 'Item1',
      category_small: 'fresh_cut',
      category_large: 'meat', quantity: 1,
      expiration_date: Time.now + 1500,
      created_at: Time.parse('Mon, July 17'),
      user_id: 1,
    )
    items << Item.create(
      name: 'Item2',
      category_small: 'cream',
      category_large: 'dairy', quantity: 2,
      expiration_date: Time.now + 3000,
      created_at: Time.parse('Mon, July 17'),
      user_id: 1,
    )
  end

  describe ".prepare_items_for_message" do
    it "returns a correctly formatted string" do
      message = Pantry::Helpers::HandlerHelper.prepare_items_for_message items
      expect(message).to eq '1 Item1 and 2 Item2'
    end
  end

  describe ".prepare_items_for_card_with_date" do
    it "returns a correctly formatted string" do
      message = Pantry::Helpers::HandlerHelper.prepare_items_for_card_with_date items
      expect(message).to eq "1 Item1 purchased on Mon, July 17\n2 Item2 purchased on Mon, July 17"
    end
  end

  describe ".prepare_items_for_card_without_date" do
    it "returns a correctly formatted string" do
      message = Pantry::Helpers::HandlerHelper.prepare_items_for_card_without_date items
      expect(message).to eq "1 Item1\n2 Item2"
    end
  end

end
