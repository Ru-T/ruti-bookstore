class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @line_items = current_order.line_items
  end
end
