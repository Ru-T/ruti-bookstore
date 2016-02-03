class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :line_items

  before_create :set_status

  def set_status
    self.status = "Pending"
  end

  def total_order_price
    line_items.to_a.sum(&:total_price)
  end
end
