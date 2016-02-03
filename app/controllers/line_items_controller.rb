class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_line_item, only: [:edit, :update]

  def create
    book = Book.find(params[:book_id])
    @line_item = LineItem.new(
      order: current_order,
      user: current_user,
      book_id: book.id,
      active: true,
      quantity: 1)
    if @line_item.save
      redirect_to cart_path(current_user), notice: "This book has been added to your cart"
    else
      redirect_to books_path, notice: "This book could not be added your cart."
    end
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
