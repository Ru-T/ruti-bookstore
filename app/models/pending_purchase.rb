class PendingPurchase < ActiveRecord::Base
  validates_presence_of :user_id, :book_id

  belongs_to :user
  belongs_to :book

  scope :pending, -> { where(purchased: false) }

  def total_price
    price_at_purchase * quantity
  end

  def was_purchased
    self.purchased = true
    save
  end

  def self.popular_books
    PendingPurchase.where(purchased: true)
                   .group(:book_id)
                   .order(quantity: :desc)
  end
end
