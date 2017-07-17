module Helpers

  class GrainCategoryHelper < SubcategoryHelper

    CATEGORIES = {
      flour: {
        warning: 340,
        expiring: 365
      },
      white_rice: {
        warning: 680,
        expiring: 730
      },
      brown_rice: {
        warning: 160,
        expiring: 180
      },
      pasta: {
        warning: 340,
        expiring: 365
      },
      cereals: {
        warning: 340,
        expiring: 365
      },
      other: {
        warning: 0,
        expiring: 0
      }
    }

    class << self

      def flour
        Set.new([
          'flour',
          'all',
          'purpose',
          'wheat',
          'buckwheat',
          'bread',
          'pastry',
          'cake',
          'spelt',
          'rye',
          'amaranth',
          '00'
        ])
      end

      def white_rice
        Set.new([
          'white',
          'rice',
          'long',
          'grain',
          'long-grain',
          'short',
          'short-grain',
          'medium',
          'medium-grain',
          'milled',
          'enriched',
          'parboiled',
          'instant',
          'converted',
          'arborio',
          'basmati',
          'glutinous',
          'sticky',
          'pingipig',
          'jasmati'
        ])
      end

      def brown_rice
        Set.new([
          'brown',
          'rice',
          'long',
          'grain',
          'long-grain',
          'short',
          'short-grain',
          'medium',
          'medium-grain',
          'basmati',
          'aromatic',
          'jasmine',
          'kalijira',
          'haiga',
          'mai',
          'haiga-mai',
          'bhutanese',
          'black',
          'japonica',
          'bomba',
          'della',
          'himalayan',
          'red',
          'kalijira',
          'sollana',
          'thai',
          'purple',
          'wehani',
          'kasmati',
          'jasmati'
        ])
      end

      def pasta
        Set.new([
          'pasta',
          'macaroni',
          'canneloni',
          'ravioli',
          'acini',
          'di',
          'pepe',
          'alphabet',
          'anelli',
          'angel',
          'hair',
          'bucatini',
          'campanelle',
          'cappelletti',
          'cavatappi',
          'casarecce',
          'cavatelli',
          'shell',
          'shells',
          'conchiglie',
          'ditalini',
          'farfalle',
          'farfalline',
          'fideo',
          'fettuccine',
          'fusilli',
          'gemelli',
          'gigli',
          'lasagna',
          'lasagne',
          'linguine',
          'mafalda',
          'manicotti',
          'orecchiette',
          'orzo',
          'pappardelle',
          'pastina',
          'penne',
          'mostaccioli',
          'rigate',
          'pipe',
          'pipette',
          'radiatori',
          'rigatoni',
          'rocchetti',
          'rotelle',
          'rotini',
          'ruote',
          'wagon',
          'wheel',
          'wheels',
          'spaghetti',
          'tagliatelle',
          'thin',
          'tortellini',
          'tortiglioni',
          'tripolini',
          'tubini',
          'vermicelli',
          'ziti'
        ])
      end

      def cereals
        Set.new([
          'granola',
          'granolas',
          'oat',
          'oats',
          'buckwheat',
          'millet',
          'finger',
          'maize',
          'barley',
          'rye',
          'wheat',
          'teff',
          'spelt',
          'chia',
          'amaranth',
          'quinoa',
          'kaniwa',
          'kiwicha'
        ])
      end

    end

  end

end
