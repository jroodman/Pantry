module Pantry

  module Handlers

    class AlexaRequestHandler

      attr_reader :request, :session
      def initialize(params)
        @request = AlexaRubykit.build_request(params)
      end

      def process
        handler = handler_for[request_type].new
        handler.process session: request.session
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
