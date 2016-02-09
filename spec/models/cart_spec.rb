require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:book) { create(:book, price_cents: 200) }
  let(:book2) { create(:book, price_cents: 500) }

  describe "#total_price" do
    it "returns the total of all line items" do
      cart.line_items.create!(book: book, quantity: 1)
      cart.line_items.create!(book: book2, quantity: 3)
      expect(cart.total_cart_price).to eq Money.new(1700)
    end
  end

  describe "#remove_from_cart" do
    it "allows a user to remove a book from his/her cart" do
      cart.line_items.create!(book: book, quantity: 1)
      cart.remove_from_cart(book)
      cart.reload
      expect(cart.line_items).to be_empty
    end
  end

  describe "#in_cart?" do
    it "checks if a book is already in a user's cart" do
      cart.line_items.create!(book: book, quantity: 1)
      expect(cart.in_cart?(book)).to eq true
      cart.remove_from_cart(book)
      cart.reload
      expect(cart.in_cart?(book)).to eq false
    end
  end
end
