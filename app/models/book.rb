class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price
  default_scope { order(published_date: :desc) }

  has_many :line_items

  monetize :price_cents
  monetize :discount_cents
  monetize :discount_price_cents

  def discount_price_cents
    if discount_cents > 0
      price_cents - discount_cents
    end
  end
end
