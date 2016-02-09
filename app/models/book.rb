class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price
  default_scope { order(published_date: :desc) }

  has_many :line_items

  def number_sold
    line_items.where(cart_id: nil).count
  end

 def self.most_popular
   Book.all.sort_by(&:number_sold).reverse
 end
end
