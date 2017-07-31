module Handlers
  module IntentRequestHandlers

    class ListIntentRequestHandler < BaseRequestHandler

      def process
        send(get_intent_specific_method(intent['name']))
      end

      private

      def get_intent_specific_method(intent_name)
        {
          'AllItems'      => :process_all_items,
          'FromCategory'  => :process_from_category,
          'Warning'       => :process_warning,
          'Expired'       => :process_expired
        }[intent_name]
      end

      def process_all_items
        items = Helpers::CategoryHelper.large_categories.flat_map do |category|
          prepare_item_list_by_category category
        end
        Helpers::HandlerHelper.create_message_response(
          message: message_for_all_items(items),
          card: {
            type: 'Simple',
            title: 'Food in your Pantry',
            content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
          },
          reprompt: 'Is there anything else I can help you with?',
          end_session: false
        )
      end

      def process_from_category
        category = intent['slots']['category']['value'].downcase.to_sym
        if Helpers::CategoryHelper.large_categories.include? category
          items = prepare_item_list_by_category category
          Helpers::HandlerHelper.create_message_response(
            message: message_for_list_items_from_category(items, category),
            card: {
              type: 'Simple',
              title: "Food in the category #{category.to_s.capitalize}",
              content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
            },
            reprompt: 'Is there anything else I can help you with?',
            end_session: false
          )
        else
          Helpers::HandlerHelper.create_message_response(
            message: "I'm sorry, the category you specified could not be found",
            reprompt: "Say what are my food categories to get a full list of supported categories",
            end_session: false
          )
        end
      end

      def process_warning
        items = Item.owned_by(user_id).before_expiration.after_warning
        Helpers::HandlerHelper.create_message_response(
          message: message_for_list_warning_items(items),
          card: {
            type: 'Simple',
            title: 'Food Expiring Soon',
            content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
          },
          reprompt: 'Is there anything else I can help you with?',
          end_session: false
        )
      end

      def process_expired
        items = Item.owned_by(user_id).after_expiration
        Helpers::HandlerHelper.create_message_response(
          message: message_for_list_expired_items(items),
          card: {
            type: 'Simple',
            title: 'Expired Food',
            content: Helpers::HandlerHelper.prepare_items_for_card_with_date(items)
          },
          reprompt: 'Is there anything else I can help you with?',
          end_session: false
        )
      end

      def prepare_item_list_by_category(category)
        items = Item.owned_by(user_id).in_category(category)
      end

      def message_for_list_items_from_category(items, category)
        items_without_duplicates = Helpers::HandlerHelper::combine_duplicate_items items
        items_for_message = Helpers::HandlerHelper.prepare_items_for_message items_without_duplicates
        if items_for_message.blank?
          "You have no food in the category #{category.to_s}"
        else
          "You have #{items_for_message}"
        end
      end

      def message_for_all_items(items)
        items_without_duplicates = Helpers::HandlerHelper::combine_duplicate_items items
        items_for_message = Helpers::HandlerHelper.prepare_items_for_message items_without_duplicates
        if items_for_message.blank?
          'You have no food in your Pantry'
        else
          "You have #{items_for_message} in your pantry"
        end
      end

      def message_for_list_warning_items(items)
        items_without_duplicates = Helpers::HandlerHelper::combine_duplicate_items items
        items_for_message = Helpers::HandlerHelper.prepare_items_for_message items_without_duplicates
        if items_for_message.blank?
          'Nothing is expiring soon'
        else
          "#{items_for_message} are expiring soon"
        end
      end

      def message_for_list_expired_items(items)
        items_without_duplicates = Helpers::HandlerHelper::combine_duplicate_items items
        items_for_message = Helpers::HandlerHelper.prepare_items_for_message items_without_duplicates
        if items_for_message.blank?
          'Nothing is expired'
        else
          "#{items_for_message} are expired"
        end
      end

    end

  end
end
