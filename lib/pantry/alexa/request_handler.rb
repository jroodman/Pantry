module Pantry

  module Alexa

    class RequestHandler

      attr_reader :request, :user_id
      def initialize(params)
        @request = AlexaRubykit.build_request params
        @user_id = User.find_or_create_by(amazon_user_id: request.session.user['userId']).id
      end

      def process
        handler = handler_for(request.type).new(self)
        handler.process
      end

      private

      def handler_for(request_type)
        {
          'INTENT_REQUEST'        => Pantry::Handlers::IntentRequestHandler,
          'LAUNCH_REQUEST'        => Pantry::Handlers::LaunchRequestHandler,
          'SESSION_ENDED_REQUEST' => Pantry::Handlers::SessionEndedRequestHandler
        }[request_type]
      end

    end

  end

end
