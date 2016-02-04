class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  def purchase_line_items
    user.cart.line_items.update_all(cart_id: nil, order_id: id)
  end
end
