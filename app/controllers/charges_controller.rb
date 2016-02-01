class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = params[:amount]
    # @amount = PendingPurchase.find(params[:pending_purchase_id]).price_at_purchase

    customer = Stripe::Customer.create(
      email:  params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      @amount,
      description: 'Bookstore purchase',
      currency:    'usd',
      receipt_email: customer.email
    )

    flash[:notice] = "Successfully created a charge"
    redirect_to pending_purchases_path
  end
end
