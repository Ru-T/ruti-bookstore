class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :cart
  has_many :orders
  has_one :credit_card

  after_save :create_cart

  def create_cart
    Cart.create(user: self)
  end

  def save_card
    customer = Stripe::Customer.create(
      email:  email,
      source: stripe_customer_token
    )
    credit_card.update(
      card_token: customer.id,
      # last_four_digits: customer.sources.data.first.last4
    )
  end
end
