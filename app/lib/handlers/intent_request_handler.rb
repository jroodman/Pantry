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
        'Add'           => Handlers::TransactionIntentRequestHandler,
        'Remove'        => Handlers::TransactionIntentRequestHandler,
        'Warning'       => Handlers::ListIntentRequestHandler,
        'Expired'       => Handlers::ListIntentRequestHandler,
        'FromCategory'  => Handlers::ListIntentRequestHandler,
        'AllItems'      => Handlers::ListIntentRequestHandler,
        'GetExpiration' => Handlers::InformationIntentRequestHandler
      }[intent]
    end

  end

end
