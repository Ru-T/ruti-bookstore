class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_line_item, only: [:edit, :update]

  def index
    @line_items = LineItem.all
  end

  def create
    book = Book.find(params[:book_id])
    current_user.add_to_cart(book)
    redirect_to cart_path(current_user), notice: "This book has been added to your cart"
  end

  def destroy
    book = LineItem.find(params[:id]).book
    current_user.remove_from_cart(book)
    redirect_to cart_path(current_user), notice: "This book has been removed from your cart"
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to cart_path(current_user), notice: "The quantity of your book has been updated"
    else
      render :edit
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # strong params
  def line_item_params
    params.require(:line_item).permit(
      :user_id,
      :book_id,
      :quantity,
      :active
    )
  end
end
