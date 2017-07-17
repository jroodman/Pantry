module Helpers

  class EggCategoryHelper < SubcategoryHelper

    CATEGORIES = {
      fresh: {
        warning: 21,
        expiring: 28
      },
      fresh_separated: {
        warning: 2,
        expiring: 4
      },
      hardboiled: {
        warning: 5,
        expiring: 7
      },
      substitutes: {
        warning: 7,
        expiring: 10
      },
      egg_containing: {
        warning: 1,
        expiring: 2
      },
      other: {
        warning: 0,
        expiring: 0
      }
    }

    class << self

      def fresh
        Set.new([
          'fresh',
          'raw',
          'egg',
          'eggs',
          'white',
          'brown',
          'nest',
          'laid',
          'nest-laid',
          'free',
          'run',
          'range',
          'free-run',
          'free-range',
          'farm',
          'farm-fresh',
          'carton',
          'pasturized',
          'organic'
        ])
      end

      def fresh_separated
        Set.new([
          'yolk',
          'yolks',
          'white',
          'whites',
          'beater',
          'beaters',
          'liquid'
        ])
      end

      def hardboiled
        Set.new([
          'hard',
          'hardcooked',
          'hard-cooked',
          'boiled',
          'hard-boiled',
          'hard-shelled',
          'hard-nosed',
          'devil',
          'devilled'
        ])
      end

      def substitutes
        Set.new([
            'substitute',
            'vegetarian',
            'vegan',
            'replace',
            'replacer'
        ])
      end

      def egg_containing
        Set.new([
            'containing',
            'custard',
            'pudding',
            'custard-filled',
            'filled',
            'pastry',
            'pastries'
        ])
      end

    end

  end

end
