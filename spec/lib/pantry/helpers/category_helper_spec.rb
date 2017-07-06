require 'rails_helper'

RSpec.describe Pantry::Helpers::CategoryHelper, type: :helper do

  describe "#self.categorize" do
    it "returns a hash containing category detail information based on an items name" do
      details = Pantry::Helpers::CategoryHelper.categorize('milk')

      expect(details).to have_key(:large_category)
      expect(details).to have_key(:small_category)
      expect(details).to have_key(:time_til_warning)
      expect(details).to have_key(:time_til_expiration)
    end
  end

  describe "#self.large_categories" do
    it "returns a list of all of the large category types" do
      large_categories = Pantry::Helpers::CategoryHelper.large_categories

      expect(large_categories).to include(:dairy)
    end
  end

end
