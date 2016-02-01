class ChargesController < ApplicationController
  def new
  end

  def create
    @pending_purchase = PendingPurchase.find(params[:pending_purchase_id])
    @pending_purchase.was_purchased
    amount = @pending_purchase.total_price * 100

    customer = Stripe::Customer.create(
      email:  params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      amount,
      description: 'Bookstore purchase',
      currency:    'usd',
      receipt_email: customer.email
    )

    flash[:notice] = "Successfully created a charge"
    redirect_to pending_purchases_path
  end
end
