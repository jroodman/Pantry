require 'set'

module Pantry

  module Helpers

    class DairyCategoryHelper
      class << self

        def categorize(item_name)
          categories_max = 0
          category_name = ''
          categories.each do |k,v|
            set = method(k).to_proc.call

            count = 0
            item_name.split(' ').each do |word|
              if set.include? word
                count += 1
              end
            end

            if count > categories_max
              category_name = k
            end
          end
          category_name.empty? ? :other : category_name
        end

        def time_til_warning(category:)
          categories[category][:warning]
        end

        def time_til_expiration(category:)
          categories[category][:expiring]
        end

        def categories
          categories = {
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
        end

        def allWords
          set = Set.new
          categories.each do |k,v|
            set.merge method(k).to_proc.call 
          end
          set
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
              "I can't believe it's not butter",

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
