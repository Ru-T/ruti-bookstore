class LineItem < ActiveRecord::Base
  validates_presence_of :cart_id, :book_id, :quantity

  belongs_to :cart
  belongs_to :book, counter_cache: :order_count
  belongs_to :order

  def total_price
    book.discounted? ? book.discount_price * quantity : book.price * quantity
  end
end
