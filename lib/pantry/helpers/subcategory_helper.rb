require 'set'

module Pantry

  module Helpers

    class SubcategoryHelper
      class << self

        def categorize(item_name)
          self::CATEGORIES.reduce({ name: :other, value: 0 }) do |max, (k,v)|
            word_set = method(k).to_proc.call
            count = (item_name.split(' ').to_set & word_set).length
            count > max[:value] ? {name: k, value: count} : max
          end[:name]
        end

        def time_til_warning(category:)
          self::CATEGORIES[category][:warning]
        end

        def time_til_expiration(category:)
          self::CATEGORIES[category][:expiring]
        end

        def allWords
          self::CATEGORIES.reduce(Set.new) do |set, (k,v)|
            set.merge method(k).to_proc.call
          end
        end

        def other
          words = Set.new([])
        end

      end
    end

  end

end
