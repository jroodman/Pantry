module Pantry

  module Handlers

    class ListIntentRequestHandler < RequestHandler

      def process
        send(get_intent_specific_method(intent['name']).call)
      end

      private

      def get_intent_specific_method(intent_name)
        {
          'Warning'       => :list_warning_items,
          'Expired'       => :list_expired_items,
          'FromCategory'  => :list_items_from_category,
          'AllItems'      => :list_all_items
        }[intent_name]
      end

      def list_items_from_category
        category = intent['slots']['category']['value'].downcase.to_sym
        if Pantry::Helpers::CategoryHelper.large_categories.include? category
          items = prepare_item_list_by_category category
          Helpers::HandlerHelper.create_response(
            message: message_for_list_items_from_category(items, category),
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
        items = Pantry::Helpers::CategoryHelper.large_categories.map do |category|
          prepare_item_list_by_category category
        end
        Helpers::HandlerHelper.create_response(
          message: message_for_all_items(items),
          card: {
            type: 'Simple',
            title: 'Items in your Pantry',
            content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
          },
          end_session: true
        )
      end

      def list_warning_items
        items = Item.owned_by(user_id).before_expiration.after_warning
        Helpers::HandlerHelper.create_response(
          message: message_for_list_warning_items(items),
          card: {
            type: 'Simple',
            title: 'Food Expiring Soon',
            content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
          },
          end_session: true
        )
      end

      def list_expired_items
        items = Item.owned_by(user_id).after_expiration
        Helpers::HandlerHelper.create_response(
          message: message_for_list_expired_items(items),
          card: {
            type: 'Simple',
            title: 'Expired Food',
            content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
          },
          end_session: true
        )
      end

      def prepare_item_list_by_category(category)
        items = Item.owned_by(user_id).in_category(category)
      end

      def message_for_list_items_from_category(items category)
        items_for_message = Helpers::HandlerHelper.prepare_items_for_message items
        if items_for_message.blank?
          "You have no items under the category #{category.to_s}"
        else
          "You have #{items_for_message} in the category #{category.to_s}"
        end
      end

      def message_for_all_items(items)
        items_for_message = Helpers::HandlerHelper.prepare_items_for_message items
        if items_for_message.blank?
          'You have no items in your Pantry'
        else
          "You have #{items_for_message} in your pantry"
        end
      end

      def message_for_list_warning_items(items)
        items_for_message = Helpers::HandlerHelper.prepare_items_for_message items
        if items_for_message.blank?
          'Nothing is expiring soon'
        else
          "#{items_for_message} are expiring soon"
        end
      end

      def message_for_list_expired_items(items)
        items_for_message = Helpers::HandlerHelper.prepare_items_for_message items
        if items_for_message.blank?
          'Nothing is expired'
        else
          "#{items_for_message} are expired"
        end
      end

    end

  end

end
