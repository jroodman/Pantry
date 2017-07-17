class Item < ApplicationRecord

  belongs_to :user

  validates :name, :category_small, :category_large, :quantity, :expiration_date, :user_id, presence: true

  scope :after_expiration, -> { where("items.expiration_date <= :time", time: Time.now) }
  scope :before_expiration, -> { where("items.expiration_date > :time", time: Time.now) }
  scope :after_warning, -> { where("items.warning_date <= :time", time: Time.now) }
  scope :owned_by, -> (user_id) { where(user_id: user_id) }
  scope :in_category, -> (category) { where(category_large: category) }

  def to_s
    name
  end

end
