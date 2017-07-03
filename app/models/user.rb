class User < ApplicationRecord

  has_many :items

  validates :amazon_user_id, presence: true, uniqueness: true

  def to_s
    amazon_user_id
  end

end
