class PendingPurchase < ActiveRecord::Base
  validates_presence_of :user_id, :book_id

  belongs_to :user
  belongs_to :book

  def total_price
    price_at_purchase * quantity
  end

  def was_purchased
    self.purchased = true
    self.save
  end

  def self.pending(user)
    pending = PendingPurchase.where(user_id: user.id)
    pending.reject { |pending_purchase| pending_purchase.purchased == true }
  end
end
