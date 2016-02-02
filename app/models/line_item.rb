class LineItem < ActiveRecord::Base
  validates_presence_of :user_id, :book_id, :quantity

  belongs_to :user
  belongs_to :book

  scope :active, -> { where(active: true) } 

  def total_price
    book.price * quantity
  end
end
