class Item < ApplicationRecord

  belongs_to :user

  validates :name, :category_small, :category_large, :quantity, :expiration_date, :user_id, presence: true

  def to_s
    name
  end

end
