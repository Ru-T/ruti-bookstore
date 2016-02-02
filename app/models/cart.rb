class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items, through: :user

  def self.total_cart_price
    line_items.sum { |line_item| line_item.total_price }
  end
end
