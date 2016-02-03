require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { create(:cart) }
  let(:book) { create(:book) }
  let(:line_item) { create(:line_item, book: book, user: cart.user, quantity: 1, active: true) }

  describe "#total_price" do
    it "returns the total of all line items" do
      expect(cart.total_cart_price).to eq 200
    end
  end
end
