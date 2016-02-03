class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
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
    )
  end
end
