class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = PendingPurchase.find(params[:pending_purchase_id]).price_at_purchase

    customer = Stripe::Customer.create(
      email:  params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      @amount,
      description: 'Rails Stripe customer',
      currency:    'usd',
      receipt_email: customer.email
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
