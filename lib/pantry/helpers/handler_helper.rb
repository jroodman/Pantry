module Pantry

  module Helpers

    class HandlerHelper

      def self.create_response(session_attributes: {}, message: , card: nil, reprompt: nil, end_session: true)
        response = AlexaRubykit::Response.new
        response.add_speech message.to_s
        session_attributes.each do |k, v|
          response.add_session_attribute k, v
        end
        if card.present?
          response.add_hash_card({ type: card[:type], title: card[:title], content: card[:content] })
        end
        if reprompt.present?
          response.add_reprompt reprompt
        end
        response.build_response(end_session)
      end

    end

  end

end
