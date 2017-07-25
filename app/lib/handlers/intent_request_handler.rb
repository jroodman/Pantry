module Handlers

  class IntentRequestHandler

    attr_reader :intent, :user_id, :dialog_state
    def initialize(context)
      @intent = context.request.intent
      @user_id = context.user_id
      @dialog_state = context.dialog_state
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
        'Add'           => Handlers::IntentRequestHandlers::TransactionIntentRequestHandler,
        'Remove'        => Handlers::IntentRequestHandlers::TransactionIntentRequestHandler,
        'Warning'       => Handlers::IntentRequestHandlers::ListIntentRequestHandler,
        'Expired'       => Handlers::IntentRequestHandlers::ListIntentRequestHandler,
        'FromCategory'  => Handlers::IntentRequestHandlers::ListIntentRequestHandler,
        'AllItems'      => Handlers::IntentRequestHandlers::ListIntentRequestHandler,
        'GetExpiration' => Handlers::IntentRequestHandlers::InformationIntentRequestHandler
      }[intent]
    end

  end

end
