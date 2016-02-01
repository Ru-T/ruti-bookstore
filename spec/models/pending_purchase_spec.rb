require 'rails_helper'

RSpec.describe PendingPurchase, type: :model do
  let(:user) { create(:user) }
  let(:pending_purchase) { create(:pending_purchase, user: user, price_at_purchase: 12, quantity: 3) }

  describe "validations" do
    it "is valid without quantity or price_at_purchase" do
      expect(build(:pending_purchase)).to be_valid
    end

    it "must have a user_id to be valid" do
      expect(build(:pending_purchase, user_id: nil)).to_not be_valid
    end

    it "must have a book_id to be valid" do
      expect(build(:pending_purchase, book_id: nil)).to_not be_valid
    end
  end

  describe "#total_price" do
    it "returns the purchase price times the quantity of the item" do
      expect(pending_purchase.total_price).to eq 36
    end
  end

  describe ".pending" do
    it "rejects all pending purchases that have been purchased" do
      pending_purchase.was_purchased
      expect(pending_purchase.purchased).to eq true
      expect(PendingPurchase.pending).to_not include pending_purchase
    end
  end

  describe "#was_purchased" do
    it "sets the purchased boolean to true" do
      pending_purchase.was_purchased
      expect(pending_purchase.purchased).to eq true
    end
  end
end
