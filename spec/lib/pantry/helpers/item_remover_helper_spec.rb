require 'rails_helper'

RSpec.describe Helpers::RemoveItemHelper do

  describe "#remove" do

    let!(:user) do
      User.create(amazon_user_id: 'sample_user_id')
    end

    let!(:item1) do
      Item.create(
        name: 'milk',
        category_small: 'milk',
        category_large: 'dairy', quantity: 1,
        expiration_date: Time.now + 1500,
        user: user,
      )
    end

    let!(:item2) do
      Item.create(
        name: 'milk',
        category_small: 'milk',
        category_large: 'dairy', quantity: 3,
        expiration_date: Time.now + 1500,
        user: user,
      )
    end

    context "the sum quantity of items with the given name is greater than the qauntity requested to remove" do

      subject { Helpers::RemoveItemHelper.new(user_id: user.id, name: 'milk', quantity: 3) }

      it "should remove and return a quantity equal to the sum quantity of items with the given name" do
        item_meta = subject.remove!

        expect(Item.find_by(id: item1.id)).to eql nil
        expect(item2.reload.quantity).to eql 1
        expect(item_meta[:quantity]).to eql 3
        expect(item_meta[:name]).to eql 'milk'
      end

    end

    context "the sum quantity of items with the given name is less than the qauntity requested to remove" do

      subject { Helpers::RemoveItemHelper.new(user_id: user.id, name: 'milk', quantity: 100) }

      it "should remove and return a quantity equal to the quantity requested to be removed" do
        item_meta = subject.remove!

        expect(Item.find_by(id: item1.id)).to eql nil
        expect(Item.find_by(id: item2.id)).to eql nil
        expect(item_meta[:quantity]).to eql 4
        expect(item_meta[:name]).to eql 'milk'
      end

    end

  end

end
