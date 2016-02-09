require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book, price_cents: 200) }
  # let(:book2) { create(:book, price_cents: 2000, discount_cents: 200) }
  let(:cart) { create(:cart) }
  let(:line_item) { create(:line_item, cart: cart, book: book, quantity: 3) }
  # let(:line_item2) { create(:line_item, cart: cart, book: book2) }

  describe "validations" do
    it "must have a cart_id to be valid" do
      expect(build(:line_item, book: book, cart_id: nil)).to_not be_valid
    end

    it "must have a book_id to be valid" do
      expect(build(:line_item, cart: cart, book_id: nil)).to_not be_valid
    end

    it "must have a quantity to be valid" do
      expect(build(:line_item, quantity: nil)).to_not be_valid
    end
  end

  describe "#total_price" do
    it "returns item price multiplied by line item quantity" do
      expect(line_item.total_price).to eq Money.new(600)
    end
  end

  # describe "#purchase_price" do
  #   it "returns the discount price or the original price if no discount" do
  #     expect(line_item.purchase_price).to eq 200
  #     expect(line_item.purchase_price).to eq 1800
  #   end
  # end
end
