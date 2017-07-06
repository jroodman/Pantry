module Pantry

  module Handlers

    class IntentRequestHandler

      attr_reader :intent
      def process(request:, user_id:)
          @intent = request.intent

          handler = handler_for(intent['name']).new
          handler.process intent: intent, user_id: user_id
      end

      private

      def handler_for(intent)
        {
          'Add'        => Pantry::Handlers::TransactionIntentRequestHandler,
          'Remove'        => Pantry::Handlers::TransactionIntentRequestHandler
        }[intent]
      end

    end

  end

end
