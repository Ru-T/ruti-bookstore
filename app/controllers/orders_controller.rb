class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def new
    @order = Order.new(user: current_user)
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: "Your order has been completed"
    else
      render :new, notice: "Your order could not be completed"
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
      :status,
      :total
    )
  end
end
