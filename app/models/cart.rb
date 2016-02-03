class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  def total_cart_price
    line_items.to_a.sum(&:total_price)
  end

  def add_to_cart(book)
    self.line_items.create!(book_id: book.id, quantity: 1)
  end

  def remove_from_cart(book)
    self.line_items.find_by_book_id(book.id).destroy
  end

  def in_cart?(book)
    self.line_items.any? { |line_item| line_item[:book_id] == book.id }
  end
end
