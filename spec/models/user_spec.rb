require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:line_item) { create(:line_item, book: book) }

  describe "#remove_from_cart" do
    it "allows a user to remove a book from his/her cart" do
      user.line_items << line_item
      user.remove_from_cart(book)
      user.reload
      expect(user.line_items).to be_empty
    end
  end

  describe "#in_cart?" do
    it "checks if a book is already in a user's cart" do
      user.line_items << line_item
      user.remove_from_cart(book)
      user.reload
      expect(user.in_cart?(book)).to eq false
    end
  end
end
