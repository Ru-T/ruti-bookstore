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
      expect(user.pending_purchases).to_not include book
    end
  end
end
