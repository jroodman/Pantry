module Handlers

  class LaunchRequestHandler < RequestHandler

    def initialize(context)
      # Stub
    end

    def process
      Helpers::HandlerHelper.create_response(
        message: 'What can my pantry do for you?',
        end_session: false
      )
    end

  end

end
