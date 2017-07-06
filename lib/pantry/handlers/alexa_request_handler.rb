module Pantry

  module Handlers

    class AlexaRequestHandler

      attr_reader :request, :user_id
      def initialize(params)
        @request = AlexaRubykit.build_request params
        @user_id = determine_user request
      end

      def process
        handler = handler_for(request.type).new
        handler.process request: request, user_id: user_id
      end

      private

      def determine_user(request)
        current_user = User.find_by amazon_user_id: request.session.user['userId']
        if !current_user.present?
          current_user = User.create amazon_user_id: request.session.user['userId']
        end
        current_user.id
      end

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
