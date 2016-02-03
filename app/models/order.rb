class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :line_items

  before_save :set_status
  before_save :add_line_items

  def set_status
    self.status = "Pending"
  end

  def add_line_items
    self.line_items = LineItem.where(active: true)
  end
end
