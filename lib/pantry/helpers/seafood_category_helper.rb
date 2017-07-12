require 'set'

module Pantry

  module Helpers

    class SeafoodCategoryHelper < SubcategoryHelper

      CATEGORIES = {
        fresh: {
          warning: 1,
          expiring: 2
        },
        fresh_shell: {
          warning: 7,
          expiring: 9
        },
        crab: {
          warning: 5,
          expiring: 7
        },
        lobster: {
          warning: 4,
          expiring: 7
        },
        shrimp: {
          warning: 3,
          expiring: 5
        },
        cooked: {
          warning: 3,
          expiring: 4
        },
        smoked: {
          warning: 8,
          expiring: 10
        },
        canned: {
          warning: 340,
          expiring: 365
        },
        dried: {
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
          words = Set.new([
              'fresh',
              'raw',
              'fish',
              'sturgeon',
              'opah',
              'moonfish',
              'ahi',
              'tuna',
              'alaskan',
              'cod',
              'rainbow',
              'trout',
              'swordfish',
              'mahi',
              'monk',
              'sole',
              'catfish',
              'chilean',
              'sea',
              'bass',
              'branzino',
              'sushi',
              'snapper',
              'salmon',
              'halibut',
              'mackerel',
              'eel',
              'flounder',
              'pollock',
              'haddock',
              'grouper',
              'dolphin',
              'yellowtail',
              'tilapia',
              'shark',
              'tilefish',
              'perch',
              'bass',
              'bluefish',
              'herring',
              'sockeye',
              'anchovy',
              'sardine',
              'albacore',
              'poke',
              'fillet',
              'fletch'
          ])
        end

        def fresh_shell
          words = Set.new([
              'shell',
              'fish',
              'shellfish',
              'crawfish',
              'krill',
              'prawn',
              'prawns',
              'squid',
              'octopus',
              'scallop',
              'scallops',
              'mussel',
              'mussels',
              'oyster',
              'oysters',
              'hardshell',
              'softshell',
              'hard-shell',
              'soft-shell',
              'cockle',
              'langostino',
              'urchin',
              'conch',
              'cuttlefish',
              'abalone',
              'mollusk',
              'snail',
              'snails',
              'crawdad',
              'crawdads',
              'crayfish',
              'clam',
              'clams'
          ])
        end

        def crab
          words = Set.new([
              'crab',
              'crabs',
              'king',
              'crabmeat',
              'legs',
              'crablegs',
              'blue',
              'soft-shell',
              'softshell',
              'hard-shell',
              'hardshell',
              'soft',
              'dungeness',
              'snow',
              'alaskan',
              'stone',
              'pacific'
          ])
        end

        def lobster
          words = Set.new([
              'lobster',
              'lobsters',
              'maine',
              'hardshell',
              'softshell',
              'hard-shell',
              'soft-shell',
              'pacific',
              'tail',
              'tails'
          ])
        end

        def shrimp
          words = Set.new([
              'shrimp',
              'gulf',
              'peeled',
              'headless',
              'headon',
              'head-on',
              'jumbo'
          ])
        end

        def cooked
          words = Set.new([
              'cooked',
              'boiled',
              'bake',
              'roast',
              'roasted',
              'broiled'
          ])
        end

        def smoked
          words = Set.new([
              'smoked',
              'cured',
              'lox',
              'nova',
              'kippered'
          ])
        end

        def canned
          words = Set.new([
            'can',
            'cans',
            'canned'
          ])
        end

        def dried
          words = Set.new([
            'dry',
            'dried',
            'pickled',
            'sun',
            'sun-dried',
            'marinated'
          ])
        end

      end

    end

  end

end
