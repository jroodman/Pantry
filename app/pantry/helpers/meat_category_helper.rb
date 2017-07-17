module Helpers

  class MeatCategoryHelper < SubcategoryHelper

    CATEGORIES = {
      fresh_cut: {
        warning: 3,
        expiring: 4
      },
      fresh_variety: {
        warning: 1,
        expiring: 2
      },
      venison: {
        warning: 4,
        expiring: 5
      },
      ground: {
        warning: 1,
        expiring: 2
      },
      lunch: {
        warning: 5,
        expiring: 7
      },
      hotdog: {
        warning: 7,
        expiring: 14
      },
      bacon: {
        warning: 5,
        expiring: 7
      },
      hard_sausage: {
        warning: 16,
        expiring: 21
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

      def fresh_cut
        Set.new([
          'cut',
          'prime',
          'rib',
          'ribs',
          'steak',
          'steaks',
          'roast',
          'roasts',
          'flat',
          'iron',
          'filet',
          'mignon',
          'sirloin',
          'chop',
          'pork',
          'angus',
          'lamb',
          'loin',
          't-bone',
          'porterhouse',
          'rack',
          'shoulder',
          'tenderloin',
          'chuck',
          'shank',
          'round',
          'flank',
          'plate',
          'brisket',
          'forequarter',
          'hindquarter',
          'aged'
        ])
      end

      def fresh_variety
        Set.new([
          'duck',
          'heart',
          'kidney',
          'kidneys',
          'liver',
          'brain',
          'brains',
          'tongue',
          'tripe',
          'sweetbread',
          'feet',
          'tail',
          'offal',
          'oxtail',
          'intestine',
          'intestines'
        ])
      end

      def venison
        Set.new([
          'venison',
          'deer',
          'buck',
          'doe',
          'fawn',
          'elk',
          'caribou',
          'escalope'
        ])
      end

      def ground
        Set.new([
          'chopped',
          'ground',
          'minced',
          'mincemeat',
          'mince',
          'hamburger'
        ])
      end

      def lunch
        Set.new([
          'lunch',
          'deli',
          'cold',
          'cuts',
          'sliced',
          'cooked',
          'bologna',
          'salami',
          'roast',
          'oven-roasted',
          'smoked',
          'mesquite',
          'pastrami',
          'mortadella',
          'honey',
          'ham',
          'sub'
        ])
      end

      def hotdog
        Set.new([
          'hotdog',
          'hotdogs',
          'frank',
          'franks',
          'frankfurter',
          'frankfurters',
          'sausage',
          'sausages',
          'dog',
          'dogs',
          'weenie',
          'weenies',
          'wiener',
          'wieners',
          'redhot',
          'foot',
          'long',
          'longs',
          'flaunter',
          'bratwurst',
          'brat',
          'brats',
          'johnsonville',
          'nathan',
          'nathans',
          "nathan's",
          'oscar',
          'meyer',
          'hebrew',
          'national'
        ])
      end

      def bacon
        Set.new([
          'bacon',
          'pancetta',
          'canadian',
          'streaky'
        ])
      end

      def hard_sausage
        Set.new([
          'hard',
          'sausage',
          'dry',
          'cured',
          'salami',
          'pepperoni',
          'chorizo',
          'genoa',
          'soppressata',
          'peppered',
          'nduja',
          'cotto'
        ])
      end

      def canned
        Set.new([
          'can',
          'cans',
          'canned'
        ])
      end

    end

  end

end
