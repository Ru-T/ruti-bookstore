class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    amount_in_cents = cart.total_cart_price

    customer = Stripe::Customer.create(
      email:  params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      amount_in_cents,
      description: 'Bookstore purchase',
      currency:    'usd',
      receipt_email: customer.email
    )

    flash[:notice] = "Successfully created a charge"
    redirect_to pending_purchases_path
  end
end
