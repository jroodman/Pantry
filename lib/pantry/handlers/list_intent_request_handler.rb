module Pantry

  module Handlers

    class ListIntentRequestHandler < RequestHandler

      def process
        get_intent_specific_method(intent['name']).call
      end

      private

      def get_intent_specific_method(intent_name)
        {
          'Warning'     => method(:list_warning_items).to_proc,
          'Expired'     => method(:list_expired_items).to_proc
        }[intent_name]
      end

      def list_warning_items
        items = Item.where("(items.user_id = :user_id) AND (items.expiration_date >= :time) AND (items.warning_date <= :time)", user_id: user_id, time: Time.now)
        message = prepare_items_for_message(items).blank? ? 'Nothing is expiring soon' : "#{prepare_items_for_message(items)} are expiring soon"
        Helpers::HandlerHelper.create_response(
          message: message,
          card: {
            type: 'Simple',
            title: 'Food Expiring Soon',
            content: prepare_items_for_card(items)
          },
          end_session: true
        )
      end

      def list_expired_items
        items = Item.where("(items.user_id = :user_id) AND (items.expiration_date <= :time)", user_id: user_id, time: Time.now)
        message = prepare_items_for_message(items).blank? ? 'Nothing is expired' : "#{prepare_items_for_message(items)} are expired"
        Helpers::HandlerHelper.create_response(
          message: message,
          card: {
            type: 'Simple',
            title: 'Expired Food',
            content: prepare_items_for_card(items)
          },
          end_session: true
        )
      end

      def prepare_items_for_message(items)
        items.each do |item|
          "#{item.quantity} #{item.name}"
        end.to_sentence
      end

      def prepare_items_for_card(items)
        list = items.reduce([]) do |array, item|
          array << "#{item.quantity} #{item.name} purchased on #{item.created_at.strftime("%a, %B %d")}"
        end
        list.join('\n')
      end

    end

  end

end
