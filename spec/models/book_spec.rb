require 'rails_helper'

RSpec.describe Book, type: :model do

  let(:book) { create(:book) }
  let(:book1) { create(:book) }
  let(:book2) { create(:book, price: 3000) }
  let(:lineitem) { create(:line_item, book: book2, cart_id: nil, quantity: 3) }
  let(:lineitem2) { create(:line_item, book: book1, cart_id: nil, quantity: 1) }

  describe "validations" do
    it "is valid without category or description" do
      expect(build(:book)).to be_valid
    end

    it "must have title to be valid" do
      expect(build(:book, title: "")).to_not be_valid
    end

    it "must have published_date to be valid" do
      expect(build(:book, published_date: nil)).to_not be_valid
    end

    it "must have author to be valid" do
      expect(build(:book, author: "")).to_not be_valid
    end

    it "must have price to be valid" do
      expect(build(:book, price: nil)).to_not be_valid
    end
  end

  describe '.default scope' do
    it 'orders by most recently published' do
      book2 = create(:book)
      expect(Book.first).to eq book2
    end
  end

  describe '.most_popular' do
    it 'orders by highest number purchased' do
      expect(Book.most_popular).to eq [book2.id, book1.id]
    end
  end
end
