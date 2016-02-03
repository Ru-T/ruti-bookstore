class LineItem < ActiveRecord::Base
  validates_presence_of :cart_id, :book_id, :quantity

  belongs_to :cart
  belongs_to :book
  belongs_to :order

  def total_price
    book.price * quantity
  end
end
