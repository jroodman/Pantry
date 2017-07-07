require 'set'

module Pantry

  module Helpers

    class DairyCategoryHelper

      CATEGORIES = {
        milk: {
          warning: 5,
          expiring: 7
        },
        cream: {
          warning: 7,
          expiring: 14
        },
        butter: {
          warning: 10,
          expiring: 14
        },
        margarine: {
          warning: 25,
          expiring: 30
        },
        cheese: {
          warning: 25,
          expiring: 30
        },
        yogurt: {
          warning: 25,
          expiring: 30
        },
        other: {
          warning: 0,
          expiring: 0
        }
      }

      class << self

        def categorize(item_name)
          CATEGORIES.reduce({ name: :other, value: 0 }) do |max, (k,v)|
            word_set = method(k).to_proc.call
            count = (item_name.split(' ').to_set & word_set).length
            count > max[:value] ? {name: k, value: count} : max
          end[:name]
        end

        def time_til_warning(category:)
          CATEGORIES[category][:warning]
        end

        def time_til_expiration(category:)
          CATEGORIES[category][:expiring]
        end

        def allWords
          CATEGORIES.reduce(Set.new) do |set, (k,v)|
            set.merge method(k).to_proc.call
          end
        end

        private

        def milk
          products = Set.new([
            'milk',
            'half-and-half',
            'skim',
            'whole',
            'two-percent',
            '1-percent',
            'nesquik',
            'shake'
          ])
        end

        def cream
          words = Set.new([
            'cream',
            'heavy cream',
            'sour cream',
            'half-and-half',
            'whipping',
            'clotted',
            'creme fraiche',
            'cream cheese'
          ])
        end

        def butter
          words = Set.new([
            'butter',
            'unsalted butter',
            'salted butter'
          ])
        end

        def margarine
          words = Set.new([
            'margarine',
            'smart balance',
            "I can't believe it's not butter"
          ])
        end

        def cheese
          words = Set.new([
            'cheese',
            'queso',
            'string cheese',
            'american',
            'swiss',
            'ricotta',
            'provolone',
            'parmesan',
            'muenster',
            'mozzarella',
            'jack',
            'monterey',
            'mascarpone',
            'havarti',
            'gouda',
            'gorgonzola',
            'fontina',
            'feta',
            'cheddar',
            'colby',
            'brie',
            'blue cheese',
            'manchego'
          ])
        end

        def yogurt
          words = Set.new([
            'yogurt',
            'greek yogurt',
            'eros',
            'chobani',
            'yoplait'
          ])
        end

        def other
          words = Set.new([])
        end

      end
    end

  end

end
