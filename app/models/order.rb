class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :line_items

  before_save :set_status

  def set_status
    self.status = "Purchased"
  end
end
