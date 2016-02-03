class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: "Your order has been completed"
    else
      render :new, notice: "Your order could not be completed"
    end
  end
  # def create
  #   amount_in_cents = cart.total_cart_price
  #
  #   customer = Stripe::Customer.create(
  #     email:  params[:stripeEmail],
  #     source: params[:stripeToken]
  #   )
  #
  #   charge = Stripe::Charge.create(
  #     customer:    customer.id,
  #     amount:      amount_in_cents,
  #     description: 'Bookstore purchase',
  #     currency:    'usd',
  #     receipt_email: customer.email
  #   )
  #
  #   flash[:notice] = "Successfully created a charge"
  #   redirect_to pending_purchases_path
  # end

  private

  def set_order
    @order = Order.find(params[:id])
  end
  # strong params
  def order_params
    params.require(:order).permit(
      :user_id,
      :status,
      :total
    )
  end
end
