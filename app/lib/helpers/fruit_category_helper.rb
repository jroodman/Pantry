module Helpers

  class FruitCategoryHelper < SubcategoryHelper

    CATEGORIES = {
      fresh: {
        warning: 4,
        expiring: 5
      },
      apples: {
        warning: 20,
        expiring: 30
      },
      citrus: {
        warning: 21,
        expiring: 42
      },
      grapes: {
        warning: 10,
        expiring: 21
      },
      melons: {
        warning: 6,
        expiring: 7
      },
      peaches: {
        warning: 14,
        expiring: 21
      },
      pears: {
        warning: 50,
        expiring: 90
      },
      pineapple: {
        warning: 5,
        expiring: 7
      },
      canned: {
        warning: 340,
        expiring: 365
      },
      dried: {
        warning: 150,
        expiring: 180
      },
      juice: {
        warning: 40,
        expiring: 60
      },
      other: {
        warning: 0,
        expiring: 0
      }
    }

    class << self

      def fresh
        Set.new([
          'fruit',
          'fruits',
          'mango',
          'mangoes',
          'cherry',
          'cherries',
          'strawberry',
          'strawberries',
          'apricot',
          'apricots',
          'banana',
          'bananas',
          'avocado',
          'avocadoes',
          'blackberry',
          'blackberries',
          'blueberry',
          'blueberries',
          'boysenberry',
          'boysenberries',
          'cranberry',
          'cranberries',
          'prune',
          'prunes',
          'date',
          'dates',
          'fig',
          'figs',
          'guava',
          'dragonfruit',
          'jackfruit',
          'kiwi',
          'kiwis',
          'kiwifruit',
          'kiwifruits',
          'loquat',
          'lychee',
          'passionfruit',
          'persimmon',
          'persimmons',
          'plum',
          'plums',
          'pomegranate',
          'pomegranates',
          'pomelo',
          'pomelos',
          'raspberry',
          'raspberries',
          'currant',
          'currants',
          'soursop',
          'star',
          'tomarillo',
          'tamarind',
          'ugli',
          'Yuzu'
        ])
      end

      def apples
        Set.new([
          'apple',
          'apples',
          'lady',
          'gala',
          'fuji',
          'granny',
          'smith',
          'honeycrisp',
          'cripps',
          'pink',
          'golden',
          'delicious',
          'red',
          'green'
        ])
      end

      def citrus
        Set.new([
          'citrus',
          'orange',
          'oranges',
          'lemon',
          'lemons',
          'lime',
          'limes',
          'citron',
          'clementine',
          'clementines',
          'grapefruit',
          'grapefruits',
          'key',
          'meyer',
          'tangelo',
          'tangerine',
          'tangerines',
          'yuzu',
          'mandarine'
        ])
      end

      def grapes
        Set.new([
          'grape',
          'grapes',
          'concord',
          'table',
          'red',
          'seedless',
          'finger',
          'vine',
          'champagne',
          'crimson',
          'riesling'
        ])
      end

      def melons
        Set.new([
          'melon',
          'melons',
          'watermelon',
          'watermelons',
          'cantaloupe',
          'cantaloupes',
          'seedless',
          'honeydew',
          'korean',
          'sprite',
          'hami',
          'honey',
          'dew',
          'papaya',
          'papayas'
        ])
      end

      def peaches
        Set.new([
          'peach',
          'peaches',
          'nectarine',
          'nectarines'
        ])
      end

      def pears
        Set.new([
          'pear',
          'pears',
          'anjou',
          'red',
          'green'
        ])
      end

      def pineapple
        Set.new([
          'pineapple',
          'pineapples'
        ])
      end

      def canned
        Set.new([
          'can',
          'cans',
          'canned'
        ])
      end

      def dried
        Set.new([
          'dry',
          'dried',
          'sun',
          'sun-dried',
          'maid',
          'prune',
          'prunes'
        ])
      end

      def juice
        Set.new([
          'juice',
          'squeezed',
          'minute',
          'maid',
          'punch',
          'welch',
          "welch's"
        ])
      end

    end

  end

end
