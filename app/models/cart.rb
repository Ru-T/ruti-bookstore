class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
end
