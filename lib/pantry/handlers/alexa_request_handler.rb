module Pantry

  module Handlers

    class AlexaRequestHandler

      @@handlers = {
        'INTENT_REQUEST' => 'Pantry::Handlers::IntentRequestHandler',
        'LAUNCH_REQUEST' => 'Pantry::Handlers::LaunchRequestHandler',
        'SESSION_ENDED_REQUEST' => 'Pantry::Handlers::SessionEndedRequestHandler'
      }

      attr_reader :request, :session
      def initialize(params)
        @request = AlexaRubykit.build_request(params)
      end

      def process
        handler = @@handlers[request.type].constantize.new
        handler.process session: request.session
      end

    end

  end

end
