class LineItem < ActiveRecord::Base
  validates_presence_of :user_id, :book_id

  belongs_to :user
  belongs_to :book

  # def total_price
  #   book.price * quantity
  # end
end
