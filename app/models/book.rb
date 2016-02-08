class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price
  default_scope { order(published_date: :desc) }

  has_many :line_items

  monetize :price_cents

  def self.most_popular
    books_sold = LineItem.where(cart_id: nil).order(quantity: :desc).group(:book_id)
    most_popular = []
    books_sold.each { |line_item| most_popular << line_item.book_id }
    most_popular
  end
end
