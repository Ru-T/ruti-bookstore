require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:book) { create(:book) }
  let(:line_item) { create(:line_item, cart: cart, book: book, order: nil) }
  let(:order) { create(:order, user: user) }

  describe "#purchase_line_items" do
    it "assigns cart's line items to order when order is created" do
      expect(cart.line_items).to include line_item
      order.purchase_line_items
      expect(order.reload.line_items).to include line_item
      expect(cart.reload.line_items).to be_empty
    end
  end
end
