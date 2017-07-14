module Pantry

  module Handlers

    class TransactionIntentRequestHandler < RequestHandler

      def process
        get_intent_specific_method(intent['name']).call
      end

      private

      def items
        @items ||= get_items_from_slots
      end

      def slots
        @slots ||= intent['slots'].to_h
      end

      def get_intent_specific_method(intent_name)
        {
          'Add'        => method(:add_items).to_proc,
          'Remove'     => method(:remove_items).to_proc,
        }[intent_name]
      end

      def add_items
        categorized_items = items.map do |k,v|
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
        Helpers::HandlerHelper.create_response(
          message: 'Items successfully added',
          card: {
            type: 'Simple',
            title: 'Added Items',
            content: Helpers::HandlerHelper.prepare_items_for_card_without_date(categorized_items)
          },
          end_session: true
        )
      end

      # TODO, this will be implemented later
      def remove_items

      end

      def get_items_from_slots
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
