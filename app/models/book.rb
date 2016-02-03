class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price
  has_many :line_items

  default_scope { order(published_date: :desc) }

  def price_in_dollars
    "$#{'%.2f' % (price/100)}"
  end
end
