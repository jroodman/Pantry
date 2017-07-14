module Pantry

  module Handlers

    class ListIntentRequestHandler < RequestHandler

      def process
        get_intent_specific_method(intent['name']).call
      end

      private

      def get_intent_specific_method(intent_name)
        {
          'Warning'       => method(:list_warning_items).to_proc,
          'Expired'       => method(:list_expired_items).to_proc,
          'FromCategory'  => method(:list_items_from_category).to_proc,
          'AllItems'      => method(:list_all_items).to_proc
        }[intent_name]
      end

      def list_items_from_category
        category = intent['slots']['category']['value'].downcase.to_sym
        if Pantry::Helpers::CategoryHelper.large_categories.include? category
          items = prepare_item_list_by_category category
          message = Helpers::HandlerHelper.prepare_items_for_message(items).blank? ? "You have no items under the category #{category.to_s}" : "You have #{prepare_items_for_message(items)} in the category #{category.to_s}"
          response = Helpers::HandlerHelper.create_response(
            message: message,
            card: {
              type: 'Simple',
              title: "Items in your category #{category.to_s}",
              content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
            },
            end_session: true
          )
        else
          Helpers::HandlerHelper.create_response(
            message: "I'm sorry, the category you specified could not be found",
            reprompt: "Say what are my food categories to get a full list of supported categories",
            end_session: false
          )
        end
      end

      def list_all_items
        items = Pantry::Helpers::CategoryHelper.large_categories.reduce([]) do |array, category|
          array += prepare_item_list_by_category category
        end
        message = Helpers::HandlerHelper.prepare_items_for_message(items).blank? ? 'You have no items in your Pantry' : "You have #{prepare_items_for_message(items)} in your pantry"
        Helpers::HandlerHelper.create_response(
          message: message,
          card: {
            type: 'Simple',
            title: 'Items in your Pantry',
            content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
          },
          end_session: true
        )
      end

      def list_warning_items
        items = Item.where "(items.user_id = :user_id) AND (items.expiration_date >= :time) AND (items.warning_date <= :time)", user_id: user_id, time: Time.now
        message = Helpers::HandlerHelper.prepare_items_for_message(items).blank? ? 'Nothing is expiring soon' : "#{prepare_items_for_message(items)} are expiring soon"
        Helpers::HandlerHelper.create_response(
          message: message,
          card: {
            type: 'Simple',
            title: 'Food Expiring Soon',
            content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
          },
          end_session: true
        )
      end

      def list_expired_items
        items = Item.where "(items.user_id = :user_id) AND (items.expiration_date <= :time)", user_id: user_id, time: Time.now
        message = Helpers::HandlerHelper.prepare_items_for_message(items).blank? ? 'Nothing is expired' : "#{prepare_items_for_message(items)} are expired"
        Helpers::HandlerHelper.create_response(
          message: message,
          card: {
            type: 'Simple',
            title: 'Expired Food',
            content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
          },
          end_session: true
        )
      end

      def prepare_item_list_by_category(category)
        items = Item.where "(items.user_id = :user_id) AND (items.category_large = :category)", user_id: user_id, category: category
      end

    end

  end

end
