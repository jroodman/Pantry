module Pantry

  module Handlers

    class TransactionIntentRequestHandler < RequestHandler

      def process
        categorized_items = addItems
        Helpers::HandlerHelper.create_response(
          message: 'Items successfully added',
          end_session: true
        )
      end

      private

      def items
        @items ||= getItemsFromSlots
      end

      def slots
        @slots ||= intent['slots'].to_h
      end

      def getIntentSpecificMethod(intent_name)
        {
          'Add'        => method(:addItems).to_proc,
          'Remove'     => method(:removeItems).to_proc,
        }[intent_name]
      end

      def addItems
        items.map do |k,v|
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
          item
        end
      end

      # TODO, this will be implemented later
      def removeItems(items)

      end

      def getItemsFromSlots
        slots.reduce(Hash.new) do |hash, (k,v)|
          if v['value'].present?
            quantity = v['value'].scan( /\d+/ ).first.to_i
            quantity.present? ? quantity : 1
            value = v['value'].sub(/\d+/, '').squeeze(' ').strip
            hash.merge( {value => quantity} )
          else
            hash
          end
        end
      end

    end

  end

end
