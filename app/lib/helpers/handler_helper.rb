module Helpers

  class HandlerHelper
    class << self

      def create_response(session_attributes: {}, message: , card: nil, reprompt: nil, end_session: true)
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

      def prepare_items_for_message(items)
        items.map do |item|
          "#{item.quantity} #{item.name}"
        end.to_sentence
      end

      def prepare_items_for_card_with_date(items)
        list = items.map do |item|
          "#{item.quantity} #{item.name} added on #{item.created_at.strftime("%a, %B %d")}"
        end
        list.empty? ? 'No items' : list.join("\n")
      end

      def prepare_items_for_card_without_date(items)
        list = items.map do |item|
          "#{item.quantity} #{item.name}"
        end
        list.empty? ? 'No items' : list.join("\n")
      end

    end
  end

end
