module Handlers
  module IntentRequestHandlers

    class AmazonIntentRequestHandler < BaseRequestHandler

      def process
        send(get_intent_specific_method(intent['name']))
      end

      private

      def get_intent_specific_method(intent_name)
        {
          'AMAZON.HelpIntent'   => :process_help,
          'AMAZON.StopIntent'   => :process_stop,
          'AMAZON.CancelIntent' => :process_cancel
        }[intent_name]
      end

      def process_help
        message = "Pantry Keeper is a virtual, interactive version of your own pantry. " +
          "To issue a request to Pantry Keeper, start with the invocation name of the skill, " +
          "Pantry Keeper. You can add items to your pantry with the add command, remove " +
          "items with the remove command, and find out what items are expiring soon with " +
          "the expiring command. Try, 'Alexa, ask Pantry keeper to add 3 eggs to my pantry,' " +
          "'Alexa, ask Pantry keeper to remove 2 eggs from my pantry', and 'Alexa, ask Pantry Keeper" +
          "to list all expiring items. See a longer list of example commands in the Help card in your Alexa app'"
        card_content = "Alexa, ask Pantry Keeper to add 3 eggs to my pantry\n" +
          "Alexa, ask Pantry Keeper to remove 2 eggs from my pantry\n" +
          "Alexa, ask Pantry Keeper to list all food in my pantry\n" +
          "Alexa, ask Pantry Keeper to list all food from the dairy category\n" +
          "Alexa, ask Pantry Keeper to list all expired items\n" +
          "Alexa, ask Pantry Keeper to list all food expiring soon\n" +
          "Alexa, ask Pantry Keeper how long do eggs last"
        Helpers::HandlerHelper.create_message_response(
          message: message,
          card: {
            type: 'Simple',
            title: 'Help: Example Phrases',
            content: card_content
          },
          reprompt: 'Is there anything I can help you with?',
          end_session: false
        )
      end

      def process_stop
        Helpers::HandlerHelper.create_message_response(
          end_session: true
        )
      end

      def process_cancel
        Helpers::HandlerHelper.create_message_response(
          message: 'Request cancelled',
          end_session: true
        )
      end

    end

  end
end
