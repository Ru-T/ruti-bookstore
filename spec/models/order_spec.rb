require 'rails_helper'
require 'stripe_mock'

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:book) { create(:book) }
  let(:line_item) { create(:line_item, cart: cart, book: book, order: nil) }
  let(:order) { create(:order, user: user) }
  let(:stripe_helper) { StripeMock.create_test_helper }

  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#purchase_line_items" do
    it "assigns cart's line items to order when order is created" do
      expect(cart.line_items).to include line_item
      order.purchase_line_items
      expect(order.reload.line_items).to include line_item
      expect(cart.reload.line_items).to be_empty
    end
  end

  describe "#save_with_payment" do
    it "creates an order with Stripe" do
      expect do
        Order.create(user: user, stripe_token: stripe_helper.generate_card_token)
      end.to change { Order.count }.by(1)
    end
  end
end
