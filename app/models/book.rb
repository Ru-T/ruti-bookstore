class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price
  default_scope { order(published_date: :desc) }

  has_many :line_items

  monetize :price_cents

  def self.most_popular
    books_sold = LineItem.where(cart_id: nil).group(:book_id).count.sort.sort { |a, b| b[1] <=> a[1] }
    most_popular = books_sold.map {|row| row[0]}
  end
end
