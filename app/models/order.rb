class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_one :credit_card, through: :user

  accepts_nested_attributes_for :credit_card

  def purchase_line_items
    user.cart.line_items.update_all(cart_id: nil, order_id: id)
  end

  def save_with_payment
    Stripe::Charge.create(
      customer: user.credit_card.card_token,
      amount:   total,
      currency: "usd",
      description: "Book purchase"
    )
    save
  end

  def save_card
    customer = Stripe::Customer.create(
      email:  user.email,
      source: stripe_token
    )
    user.credit_card.update(
      card_token: customer.id,
      last_four_digits: customer.sources.data.first.last4
    )
    save
  end
end
