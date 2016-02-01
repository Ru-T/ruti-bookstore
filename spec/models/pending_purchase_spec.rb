require 'rails_helper'

RSpec.describe PendingPurchase, type: :model do
  let(:pending_purchase) { FactoryGirl.create(:pending_purchase) }

  describe "validations" do
    it "is valid without quantity or price_at_purchase" do
      expect(FactoryGirl.build(:pending_purchase)).to be_valid
    end

    it "must have a user_id to be valid" do
      expect(FactoryGirl.build(:pending_purchase, user_id: nil)).to_not be_valid
    end

    it "must have a book_id to be valid" do
      expect(FactoryGirl.build(:pending_purchase, book_id: nil)).to_not be_valid
    end
  end

  describe "#total_price" do
    it "returns the purchase price times the quantity of the item" do
      cart_item = FactoryGirl.build(:pending_purchase, price_at_purchase: 12, quantity: 3)
      expect(cart_item.total_price).to eq 36
    end
  end
end
