module Handlers

  class TransactionIntentRequestHandler < RequestHandler

    def process
      send(get_intent_specific_method(intent['name']))
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
        'Add'        => :process_add_items,
        'Remove'     => :process_remove_items,
      }[intent_name]
    end

    def process_add_items
      Helpers::HandlerHelper.create_response(
        message: 'Items successfully added',
        card: {
          type: 'Simple',
          title: 'Added Items',
          content: Helpers::HandlerHelper.prepare_items_for_card_without_date(added_items)
        },
        reprompt: 'Is there anything else I can help you with?',
        end_session: true
      )
    end

    def process_remove_items
      Helpers::HandlerHelper.create_response(
        message: "#{Helpers::HandlerHelper.prepare_removed_items_for_message(removed_items)} were removed",
        card: {
          type: 'Simple',
          title: 'Removed Items',
          content: Helpers::HandlerHelper.prepare_removed_items_for_card(removed_items)
        },
        reprompt: 'Is there anything else I can help you with?',
        end_session: true
      )
    end

    def added_items
      items.reject{ |k,v| v <= 0 }.map do |k,v|
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

    def removed_items
      items.map do |k,v|
        item = Item.owned_by(user_id).where(name: k).order(:created_at).first
        item_meta = {name: k, quantity: v}
        while item.present? && v > 0 do
          v -= item.quantity
          item.quantity = (item.quantity - v >= 0) ? item.quantity - v : 0
          if item.quantity == 0
            item.destroy
            item = Item.owned_by(user_id).where(name: k).order(:created_at).first
          end
        end
        item_meta[:quantity] -= v if v.positive?
        item.save if item.present?
        item_meta
      end
    end

    def get_items_from_slots
      slots.reduce(Hash.new) do |hash, (k,v)|
        if v['value'].present?
          quantity = v['value'].scan( /\d+/ ).first.to_i
          quantity.present? ? quantity : 1
          value = v['value'].sub(/\d+/, '').squeeze(' ').strip
          hash.merge(value => quantity)
        else
          hash
        end
      end
    end

  end

end
