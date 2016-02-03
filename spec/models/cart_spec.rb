require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:book) { create(:book, price: 200) }
  let(:book2) { create(:book, price: 500) }

  describe "#total_price" do
    it "returns the total of all line items" do
      cart.add_to_cart(book)
      cart.add_to_cart(book2)
      expect(cart.total_cart_price).to eq 700
    end
  end

  describe "#add_to_cart" do
    it "allows a user to add a book to his/her cart" do
      cart.add_to_cart(book)
      expect(cart.line_items.last.book_id).to eq book.id
    end
  end

  describe "#remove_from_cart" do
    it "allows a user to remove a book from his/her cart" do
      cart.add_to_cart(book)
      cart.remove_from_cart(book)
      cart.reload
      expect(cart.line_items).to be_empty
    end
  end

  describe "#in_cart?" do
    it "checks if a book is already in a user's cart" do
      cart.add_to_cart(book)
      expect(cart.in_cart?(book)).to eq true
      cart.remove_from_cart(book)
      cart.reload
      expect(cart.in_cart?(book)).to eq false
    end
  end
end
