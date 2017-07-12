require 'set'

module Pantry

  module Helpers

    class DairyCategoryHelper < SubcategoryHelper

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

        def milk
          words = Set.new([
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
            'heavy',
            'sour',
            'half-and-half',
            'whipping',
            'clotted',
            'creme',
            'fraiche',
            'cheese'
          ])
        end

        def butter
          words = Set.new([
            'butter',
            'unsalted',
            'salted'
          ])
        end

        def margarine
          words = Set.new([
            'margarine',
            'smart balance'
          ])
        end

        def cheese
          words = Set.new([
            'cheese',
            'queso',
            'string',
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
            'blue',
            'manchego'
          ])
        end

        def yogurt
          words = Set.new([
            'yogurt',
            'greek',
            'eros',
            'chobani',
            'yoplait'
          ])
        end

      end

    end

  end

end
