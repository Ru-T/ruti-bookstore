class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price
  has_many :line_items

  default_scope { order(published_date: :desc) }
end
