module Handlers
  module IntentRequestHandlers

    class BaseRequestHandler

      attr_reader :intent, :user_id
      def initialize(context)
        @intent = context.intent
        @user_id = context.user_id
      end

    end

  end
end
