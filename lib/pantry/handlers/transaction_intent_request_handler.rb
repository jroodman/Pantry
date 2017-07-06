module Pantry

  module Handlers

    class TransactionIntentRequestHandler

      def process(intent:, user_id:)
        items = getItemsFromSlots intent['slots']
        categorized_items = addItems items, user_id
        Helpers::HandlerHelper.create_response(
          message: 'Items successfully added',
          end_session: true
        )
      end

      private

      def getIntentSpecificMethod(intent_name)
        {
          'Add'        => method(:addItems).to_proc,
          'Remove'        => method(:removeItems).to_proc,
        }[intent_name]
      end

      def addItems(items, user_id)
        categorized_items = []
        items.each do |k,v|
          details = Helpers::CategoryHelper.categorize k
          item = Item.new(
            name: k,
            category_small: details[:small_category],
            category_large: details[:large_category],
            quantity: v,
            warning_date: Time.now + details[:time_til_warning].days,
            expiration_date: Time.now + details[:time_til_expiration].days,
            user_id: user_id
          )
          if details[:time_til_warning] != 0
            item[:warning_date] = Time.now + details[:time_til_warning].days
          end
          if details[:time_til_expiration] != 0
            item[:expiration_date] = Time.now + details[:time_til_expiration].days
          end
          item.save
          categorized_items.push item
        end
        categorized_items
      end

      def removeItems(items)

      end

      def getItemsFromSlots(slots)
        items = {}
        slots.each do |k, v|
          if v['value'].present?
            quantity = v['value'].scan( /\d+/ ).first.to_i
            items[v['value']] = quantity.present? ? quantity : 1
          end
        end
        items
      end

    end

  end

end
