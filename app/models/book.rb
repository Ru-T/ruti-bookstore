class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price
  default_scope { order(published_date: :desc) }

  has_many :pending_purchases
end
