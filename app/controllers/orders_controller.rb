class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def new
    @order = Order.new(user: current_user)
    @credit_card = @order.user.build_credit_card
  end

  def create
    @order = Order.new(order_params.merge(user: current_user, total: current_user.cart.total_cart_price))
    if @order.save
      @order.purchase_line_items

      customer = Stripe::Customer.create(
        email:  @order.user.email,
        source: params[:stripeToken]
      )
      @order.card_token = customer.id
      @order.save

      amount = @order.total

      charge = Stripe::Charge.create(
        customer:    customer.id,
        amount:      amount,
        currency:    'usd',
        description: 'Bookstore purchase'
      )

      OrderMailer.receipt_email(@order.user).deliver_now
      # @order.credit_card.last_four_digits = customer.data.last4
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
      :shipping_zip,
      credit_card_attributes: [
        :id,
        :billing_address1,
        :billing_address2,
        :billing_city,
        :billing_state,
        :billing_zip,
        :last_four_digits
      ]
    )
  end
end
