module Handlers

  class InformationIntentRequestHandler < RequestHandler

    def process
      send(get_intent_specific_method(intent['name']))
    end

    private

    def get_intent_specific_method(intent_name)
      {
        'GetExpiration' => :process_get_expiration
      }[intent_name]
    end

    def item
      @item ||= intent['slots']['item']['value']
    end

    def item_details
      @item_details ||= Helpers::CategoryHelper.categorize item
    end

    def message
      if item_details[:small_category] == :other
        message = "Unable to find expiry information for #{item}"
      else
        message = "When appropriately stored, #{item} is good for #{item_details[:time_til_expiration]} days"
      end
    end

    def process_get_expiration
      Helpers::HandlerHelper.create_response(
        message: message,
        card: {
          type: 'Simple',
          title: "#{item}",
          content: message
        },
        reprompt: 'Is there anything else I can help you with?',
        end_session: false
      )
    end

  end

end
