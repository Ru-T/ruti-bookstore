require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:user) { create(:user) }
  let(:line_item) { create(:line_item) }

  describe "validations" do
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
end
