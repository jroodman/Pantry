module Helpers

  class CategoryHelper
    class << self

      def categorize(item_name)
        large_category = determine_large_category(item_name)
        small_category = helper_for(large_category).categorize(item_name)
        details = {
          large_category: large_category,
          small_category: small_category,
          time_til_warning: helper_for(large_category).time_til_warning(category: small_category),
          time_til_expiration: helper_for(large_category).time_til_expiration(category: small_category)
        }
      end

      def large_categories
        [
            :dairy,
            :meat,
            :poultry,
            :eggs,
            :seafood,
            :fruit,
            :vegetable,
            :grain,
            :other
        ]
      end

      private

      def determine_large_category(item_name)
        categories_max = 0
        category_name = ''
        large_categories.each do |category|
          set = helper_for(category).all_words

          count = 0
          item_name.split(' ').each do |word|
            if set.include? word
              count += 1
            end
          end

          if count > categories_max
            categories_max = count
            category_name = category
          end
        end
        category_name.empty? ? :other : category_name
      end

      def helper_for(large_category)
        "Helpers::CategoryHelpers::#{large_category.to_s.classify}CategoryHelper".constantize
      end

    end
  end

end
