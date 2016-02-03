require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:line_item) { create(:line_item, book: book, quantity: 3) }
  let(:line_item2) { create(:line_item, active: false) }

  describe "validations" do
    it "is valid without active flag" do
      expect(build(:line_item)).to be_valid
    end

    it "must have a user_id to be valid" do
      expect(build(:line_item, user_id: nil)).to_not be_valid
    end

    it "must have a book_id to be valid" do
      expect(build(:line_item, book_id: nil)).to_not be_valid
    end

    it "must have a quantity to be valid" do
      expect(build(:line_item, quantity: nil)).to_not be_valid
    end
  end

  describe "#total_price" do
    it "returns item price multiplied by line item quantity" do
      expect(line_item.total_price).to eq 600
    end
  end

  describe ".active" do
    it "returns only active line items" do
      expect(LineItem.active).to_not include line_item2
    end
  end
end
