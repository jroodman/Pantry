module Pantry

  module Handlers

    class LaunchRequestHandler < RequestHandler

      def process
        Helpers::HandlerHelper.create_response(
          message: 'What can my pantry do for you?',
          end_session: false
        )
      end

    end

  end

end
