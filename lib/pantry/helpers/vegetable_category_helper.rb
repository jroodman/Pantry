require 'set'

module Pantry

  module Helpers

    class VegetableCategoryHelper < SubcategoryHelper

      CATEGORIES = {
        asparagus: {
          warning: 2,
          expiring: 3
        },
        corn: {
          warning: 1,
          expiring: 1
        },
        short_period: {
          warning: 3,
          expiring: 5
        },
        medium_period: {
          warning: 5,
          expiring: 7
        },
        long_period: {
          warning: 10,
          expiring: 14
        },
        canned: {
          warning: 340,
          expiring: 365
        },
        other: {
          warning: 0,
          expiring: 0
        }
      }

      class << self

        def asparagus
          words = Set.new([
            'asparagus',
            'garden',
            'shoot',
            'shoots'
          ])
        end

        def corn
          words = Set.new([
            'corn',
            'husk',
            'maize',
            'white',
            'sweet'
          ])
        end

        def short_period
          words = Set.new([
            'broccoli',
            'broccolini',
            'stalk',
            'calabrese',
            'brussel',
            'sprout',
            'sprouts',
            'green',
            'peas',
            'pea',
            'rhubarb',
            'summer',
            'squash',
            'costata',
            'yellow',
            'pattypan',
            'cousa',
            'zephyr',
            'mushroom',
            'mushrooms',
            'shiitake',
            'chanterelle',
            'chanterelles',
            'cremini',
            'morel',
            'morels',
            'portobello',
            'enoki',
            'button',
            'porcini',
            'greens',
            'lima',
            'bean',
            'beans',
            'scallion',
            'scallions',
            'lettuce',
            'arugula',
            'butterhead',
            'iceberg',
            'oak',
            'romaine',
            'leaf',
            'leafy',
            'spinach',
            'swiss',
            'chard',
            'kale'
          ])
        end

        def medium_period
          words = Set.new([
            'cabbage',
            'cauliflower',
            'celery',
            'stick',
            'sticks',
            'cucumber',
            'zuchini',
            'squash',
            'red',
            'yellow',
            'green',
            'pepper',
            'peppers',
            'bell',
            'poblano',
            'anaheim',
            'serrano',
            'habanero'
          ])
        end

        def long_period
          words = Set.new([
            'carrot',
            'carrots',
            'beet',
            'beets',
            'parsnip',
            'parsnips',
            'radish',
            'radishes',
            'turnip',
            'turnips',
            'white',
            'sweet',
            'potato',
            'potatoes',
            'winter',
            'squash',
            'kabocha',
            'butternut',
            'carnival',
            'pumpkin',
            'pumpkins',
            'spaghetti',
            'kuri',
            'delicata',
            'buttercup',
            'acorn',
            'rutabaga',
            'rutabagas'
          ])
        end

        def canned
          words = Set.new([
            'can',
            'cans',
            'canned',
            'dry',
            'dried'
          ])
        end

      end

    end

  end

end
