class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price

  has_many :line_items

  monetize :price_cents
  # monetize :discount_cents
  monetize :discount_price_cents

  def discount_price_cents
    price_cents - discount_cents if price_cents
  end

  def discounted?
    discount_cents > 0
  end
end
