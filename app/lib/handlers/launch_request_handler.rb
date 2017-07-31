module Handlers

  class LaunchRequestHandler

    attr_reader :user_id
    def initialize(context)
      @user_id = context.user_id
    end

    def process
      expired_items = Item.owned_by(user_id).after_expiration
      expiring_items = Item.owned_by(user_id).before_expiration.after_warning
      if
      Helpers::HandlerHelper.create_message_response(
        message: 'Welcome to Pantry Keeper. ' + create_message.to_s + 'Is there anything you would like me to do?',
        end_session: false
      )
    end

    private

    def create_message
      expired_items = get_expired_items.to_s
      expiring_items = get_expiring_items.to_s
      if !expiring_items.blank? && !expired_items.blank?
        expired_items + ' and ' + expiring_items + '.'
      else !expiring_items.blank? || !expired_items.blank?
         expired_items + expiring_items + '. '
    end

    def get_expiring_items
      items = Item.owned_by(user_id).before_expiration.after_warning
      items_without_duplicates = Helpers::HandlerHelper::combine_duplicate_items items
      items_for_message = Helpers::HandlerHelper.prepare_items_for_message items_without_duplicates
      if !items_for_message.blank?
        "#{items_for_message} are expiring soon"
      end
    end

    def get_expired_items
      items = Item.owned_by(user_id).after_expiration
      items_without_duplicates = Helpers::HandlerHelper::combine_duplicate_items items
      items_for_message = Helpers::HandlerHelper.prepare_items_for_message items_without_duplicates
      if !items_for_message.blank?
        "#{items_for_message} are expired"
      end
    end

  end

end
