require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:book) { create(:book, price: 200) }
  let(:book2) { create(:book, price: 500) }

  describe "#total_price" do
    it "returns the total of all line items" do
      user.add_to_cart(book)
      user.add_to_cart(book2)
      expect(cart.total_cart_price).to eq 700
    end
  end
end
