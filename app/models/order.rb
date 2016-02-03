class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  def purchase_line_items
    LineItem.where(cart: user.cart).update_all(cart_id: nil, order_id: id)
  end

  def save_with_payment
    Stripe::Customer.create(description: email, card: card_token)
    self.card_token = customer.id
    save!
  end
end
