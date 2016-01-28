class PendingPurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pending_purchase, only: [:edit, :update]

  def index
    @pending_purchases = PendingPurchase.where(user: current_user)
  end

  def create
    book = Book.find(params[:book_id])
    current_user.add_to_cart(book)
    redirect_to pending_purchases_path, notice: "This book has been added to your cart"
  end

  def destroy
    book = Book.find(params[:book_id])
    current_user.remove_from_cart(book)
    redirect_to pending_purchases_path, notice: "This book has been removed from your cart"
  end

  def update
    if @pending_purchase.update(pending_purchase_params)
      redirect_to pending_purchases_path, notice: "The quantity of your book has been updated"
    else
      render :edit
    end
  end

  private

  def set_pending_purchase
    @pending_purchase = PendingPurchase.find(params[:id])
  end

  # strong params
  def pending_purchase_params
    params.require(:pending_purchase).permit(
      :user_id,
      :book_id,
      :quantity,
      :price_at_purchase
    )
  end
end
