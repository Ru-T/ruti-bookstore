class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_one :credit_card, through: :user

  accepts_nested_attributes_for :credit_card

  def purchase_line_items
    user.cart.line_items.update_all(cart_id: nil, order_id: id)
  end

  def save_with_payment
    charge = Stripe::Charge.create(
      customer: self.card_token,
      amount:   self.total,
      currency: "usd",
      description: "Book purchase"
    )
  end

  # self.credit_card.last_four_digits = customer.sources.data.first.last4
  # self.credit_card.card_token = customer.id
  # save!
end
