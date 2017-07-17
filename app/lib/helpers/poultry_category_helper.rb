module Helpers

  class PoultryCategoryHelper < SubcategoryHelper

    CATEGORIES = {
      fresh: {
        warning: 2,
        expiring: 3
      },
      cooked: {
        warning: 2,
        expiring: 3
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
          'poultry',
          'chicken',
          'turkey',
          'hen',
          'rooster',
          'cock',
          'pheasant',
          'game',
          'broiler',
          'fryer',
          'roaster',
          'capon',
          'fowl',
          'duck',
          'goose',
          'pigeon',
          'foie',
          'gras',
          'breast',
          'wing',
          'thigh',
          'drumstick',
          'leg',
          'tender',
          'drumette',
          'quartered',
          'quarter',
          'whole',
          'skinless',
          'boneless'
        ])
      end

      def cooked
        Set.new([
          'cooked',
          'roast',
          'roasted',
          'oven',
          'baked',
          'grilled',
          'rotisserie',
          'fried'
        ])
      end

    end

  end

end
