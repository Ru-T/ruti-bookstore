class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  monetize :total_cart_price

  def total_cart_price
    line_items.to_a.sum(&:total_price)
  end

  def remove_from_cart(book)
    line_items.find_by_book_id(book.id).destroy
  end

  def in_cart?(book)
    line_items.any? { |line_item| line_item[:book_id] == book.id }
  end
end
