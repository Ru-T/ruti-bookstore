require 'rails_helper'

RSpec.describe Book, type: :model do

  let(:book) { create(:book) }
  let(:book1) { create(:book, price_cents: 100) }
  let(:line_item) { create(:line_item, book: book, quantity: 3, cart_id: nil) }
  let(:line_item) { create(:line_item, book: book1, quantity: 12, cart_id: nil) }

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
      expect(build(:book, price_cents: nil)).to_not be_valid
    end
  end

  describe '.default scope' do
    it 'orders by most recently published' do
      book2 = create(:book)
      expect(Book.first).to eq book2
    end
  end

  describe '.most_popular' do
    it 'orders by most popular' do
      expect(Book.most_popular).to eq [book1.id, book.id]
    end
  end
end
