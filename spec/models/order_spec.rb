require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:book) { create(:book) }
  let(:line_item) { create(:line_item, cart: cart, book: book) }
  let(:order) { create(:order, user: user) }

  describe "#purchase_line_items" do
    it "assigns cart's line items to order when order is created" do
      order.purchase_line_items
      order.reload
      expect(cart.line_items).to be_empty
      expect(order.line_items).to include line_item
    end
  end
end
