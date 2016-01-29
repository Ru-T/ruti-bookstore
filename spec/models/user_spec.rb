require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

  describe "#add_to_cart" do
    it "allows a user to add a book to his/her cart" do
      user.add_to_cart(book)
      expect(user.pending_purchases.last.book_id).to eq book.id
    end
  end

  describe "#remove_from_cart" do
    it "allows a user to remove a book from his/her cart" do
      user.add_to_cart(book)
      user.remove_from_cart(book)
      user.reload
      expect(user.pending_purchases).to be_empty
    end
  end

  describe "#in_cart?" do
    it "checks if a book is already in a user's cart" do
      user.add_to_cart(book)
      expect(user.in_cart?(book)).to eq true
      user.remove_from_cart(book)
      user.reload
      expect(user.in_cart?(book)).to eq false
    end
  end
end
