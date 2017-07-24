module Helpers

  class RemoveItemHelper

    attr_reader :user_id, :name, :items, :quantity_to_remove
    attr_accessor :remove_quantity
    def initialize(user_id:, name:, quantity:)
      @user_id            = user_id
      @name               = name
      @quantity_to_remove = quantity
      @remove_quantity    = quantity
      @items              = Item.owned_by(user_id).where(name: name).order(:created_at).to_a
    end

    def remove!
      return item_meta unless item.present? and remove_quantity.positive?

      if remove_quantity >= item.quantity
        self.remove_quantity -= item.quantity
        item.destroy
      else
        item.update_attributes(quantity: item.quantity - remove_quantity)
        self.remove_quantity = 0
      end

      items.shift and remove!
    end

    def item
      items.first
    end

    def item_meta
      {
        name:     name,
        quantity: quantity_to_remove - remove_quantity
      }
    end
  end

end
