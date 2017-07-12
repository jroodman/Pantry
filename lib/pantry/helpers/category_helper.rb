require 'set'

module Pantry

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
          categories = [
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
            set = helper_for(category).allWords

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
          {
            :dairy          => Pantry::Helpers::DairyCategoryHelper,
            :meat           => Pantry::Helpers::MeatCategoryHelper,
            :poultry        => Pantry::Helpers::PoultryCategoryHelper,
            :eggs           => Pantry::Helpers::EggCategoryHelper,
            :seafood        => Pantry::Helpers::SeafoodCategoryHelper,
            :fruit          => Pantry::Helpers::FruitCategoryHelper,
            :vegetable      => Pantry::Helpers::VegetableCategoryHelper,
            :grain          => Pantry::Helpers::GrainCategoryHelper,
            :other          => Pantry::Helpers::OtherCategoryHelper
          }[large_category]
        end

      end
    end

  end

end
