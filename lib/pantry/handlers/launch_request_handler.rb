module Pantry

  module Handlers

    class LaunchRequestHandler

      def process( session: )
        Helpers::HandlerHelper.create_response(
          message: 'What would you like to add or remove from your pantry?',
          end_session: false
        )
      end

    end

  end

end