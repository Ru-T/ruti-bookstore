class PendingPurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pending_purchases = PendingPurchase.where(user: current_user)
  end

  def create
    book = Book.find(params[:book_id])
    current_user.pending_purchase(book)
    redirect_to pending_purchases_path, notice: "This book has been added to your cart"
  end

  private

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
