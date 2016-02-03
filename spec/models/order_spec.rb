require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }
  let(:line_item) { create(:line_item) }

  describe "#set_status" do
    it "sets status on a created order" do
      expect(order.status).to eq "Pending"
    end
  end
end
