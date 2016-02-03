class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  def total_cart_price
    line_items.to_a.sum(&:total_price)
  end
end
