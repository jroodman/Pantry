module Pantry

  module Handlers

    class IntentRequestHandler < RequestHandler

      attr_reader :intent, :user_id
      def initialize(context)
        @intent = context.request.intent
        @user_id = context.user_id
      end

      attr_reader :handler
      def handler
        @handler ||= handler_for(intent['name']).new(self)
      end

      def process
        handler.process
      end

      private

      def handler_for(intent)
        {
          'Add'           => Pantry::Handlers::TransactionIntentRequestHandler,
          'Remove'        => Pantry::Handlers::TransactionIntentRequestHandler,
          'Warning'       => Pantry::Handlers::ListIntentRequestHandler,
          'Expired'       => Pantry::Handlers::ListIntentRequestHandler,
          'FromCategory'  => Pantry::Handlers::ListIntentRequestHandler,
          'AllItems'      => Pantry::Handlers::ListIntentRequestHandler
        }[intent]
      end

    end

  end

end
