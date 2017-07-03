require 'rails_helper'

RSpec.describe Item, type: :model do

  let!(:user) do
    User.create(amazon_user_id: 'testAmazonUserID')
  end

  subject do
    Item.create(
      name: 'package of corn',
      category_small: 'corn',
      category_large: 'produce',
      expiration_date: DateTime.current,
      user: user
    )
  end

  it { should belong_to(:user) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :category_small }
  it { should validate_presence_of :category_large }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :expiration_date }
  it { should validate_presence_of :user_id }

  describe "#to_s" do
    it "returns the item's name" do
      expect(subject.to_s).to eql 'package of corn'
    end
  end

end
