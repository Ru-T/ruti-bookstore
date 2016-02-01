class PendingPurchase < ActiveRecord::Base
  validates_presence_of :user_id, :book_id

  belongs_to :user
  belongs_to :book

  def total_price
    price_at_purchase * quantity
  end

  def was_purchased
    self.purchased = true
  end

  def self.not_yet_purchased
    PendingPurchase.all.reject { |pending_purchase| pending_purchase.purchased == true }
  end
end
