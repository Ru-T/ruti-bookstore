class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(user: current_user, total: current_user.cart.total_cart_price)
    if @order.save
      @order.purchase_line_items

      customer = Stripe::Customer.create(
        email:  @order.user.email,
        source: params[:stripeToken]
      )
      @order.card_token = customer.id

      amount = @order.total

      charge = Stripe::Charge.create(
        customer:    customer.id,
        amount:      amount,
        currency:    'usd',
        description: 'Bookstore purchase'
      )

      redirect_to order_path(@order), notice: "Your order has been completed"
    else
      redirect to cart_path(current_user), notice: "Your order could not be processed."
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  # strong params
  def order_params
    params.require(:order).permit(
      :user_id,
      :total,
      :card_token,
      :shipping_address1,
      :shipping_address2,
      :shipping_city,
      :shipping_state,
      :shipping_zip
    )
  end
end
