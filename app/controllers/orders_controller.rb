class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def new
    @order = Order.new(user: current_user)
    @order.user.credit_card = @order.user.build_credit_card
  end

  def create
    @order = Order.new(
      order_params.merge(
        user: current_user,
        total: current_user.cart.total_cart_price,
        stripeToken: params[:stripeToken]
      )
    )
    if @order.save
      customer = Stripe::Customer.create(
        email:  @order.user.email,
        source: params[:stripeToken]
      )
      @order.credit_card.update(
        card_token: customer.id,
        last_four_digits: customer.sources.data.first.last4
      )
      @order.save_with_payment
      @order.purchase_line_items
      OrderMailer.receipt_email(@order.user).deliver_now
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
      :stripeToken,
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
        :last_four_digits,
        :card_token
      ]
    )
  end
end
