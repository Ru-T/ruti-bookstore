class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = Cart.where(user: current_user)
  end
end
