class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price

  has_many :pending_purchases
end
