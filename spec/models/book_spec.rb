require 'rails_helper'

RSpec.describe Book, type: :model do

  let(:book) { create(:book) }
  let(:book1) { create(:book) }
  let(:line_item2) { create(:line_item, cart_id: nil, book: book1) }

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
    it 'orders by most popular' do
      expect(book).to eq book
      expect(book1).to eq book1
      expect(Book.all.most_popular).to eq [book1, book]
    end
  end
end
