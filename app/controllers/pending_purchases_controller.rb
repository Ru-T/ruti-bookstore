class PendingPurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pending_purchases = PendingPurchase.all
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
