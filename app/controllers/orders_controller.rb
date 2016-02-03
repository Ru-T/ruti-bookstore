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
      :total
      :card_token
    )
  end
end
