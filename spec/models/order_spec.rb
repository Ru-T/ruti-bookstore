require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }
  let(:book) { create(:book, price: 700) }
  let(:book2) { create(:book, price: 1000) }
  let(:line_item) { create(:line_item, book: book) }
  let(:line_item2) { create(:line_item, book: book2, quantity: 3) }

  describe "#set_status" do
    it "sets status on a created order" do
      expect(order.status).to eq "Pending"
    end
  end

  describe "#total_order_price" do
    it "returns the total of all line items" do
      order.line_items << line_item
      order.line_items << line_item2
      expect(order.total_order_price).to eq 3700
    end
  end
end
