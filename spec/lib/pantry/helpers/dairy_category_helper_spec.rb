require 'rails_helper'

RSpec.describe Pantry::Helpers::DairyCategoryHelper, type: :helper do

  describe "#self.categorize" do
    it "returns a category corresponding to an item name if one matches" do
      category_name = Pantry::Helpers::DairyCategoryHelper.categorize 'milk'

      expect(category_name).to eq :milk
    end

    it "returns the :other category if the item name matches with no other categories" do
      category_name = Pantry::Helpers::DairyCategoryHelper.categorize 'meat'

      expect(category_name).to eq :other
    end
  end

  describe "#self.time_til_warning" do
    it "returns the amount of time in days until an item in a given category creates an expiration warning" do
      time = Pantry::Helpers::DairyCategoryHelper.time_til_warning(category: :milk)

      expect(time).to eq 5
    end
  end

  describe "#self.time_til_expiration" do
    it "returns the amount of time in days until an item in a given category expires" do
      time = Pantry::Helpers::DairyCategoryHelper.time_til_expiration(category: :milk)

      expect(time).to eq 7
    end
  end

  describe "#self.categories" do
    it "returns all small categories corresponding to the large cateogry dairy" do
      categories = Pantry::Helpers::DairyCategoryHelper.categories

      expect(categories).to have_key(:milk)
      expect(categories).to have_key(:cream)
      expect(categories).to have_key(:butter)
      expect(categories).to have_key(:margarine)
      expect(categories).to have_key(:cheese)
      expect(categories).to have_key(:yogurt)
      expect(categories).to have_key(:other)
    end
  end

  describe "#self.categories" do
    it "returns all words associated with dairy in a set" do
      allWords = Pantry::Helpers::DairyCategoryHelper.allWords

      expect(allWords).to include('1-percent')
      expect(allWords).to include('whipping')
      expect(allWords).to include('butter')
      expect(allWords).to include('yoplait')
    end
  end

end
