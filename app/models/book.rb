class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price

  has_many :line_items

  monetize :price_cents
end
