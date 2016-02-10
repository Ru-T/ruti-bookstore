require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { create(:book) }
  let(:book1) { create(:book, price_cents: 200, discount_cents: 20) }

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

  describe 'default sort without sort params' do
    it 'orders by most recently published' do
      book2 = create(:book)
      expect(Book.first).to eq book2
    end
  end

  describe '#monetize' do
    it 'monetizes the price field of a book' do
      expect(book).to monetize(:price)
    end
  end

  describe '#discount_price' do
    it 'returns the book price minus the discount' do
      expect(book1.discount_price_cents).to eq 180
    end
  end

  describe '#discounted?' do
    it 'returns true if the book has a discount_cents value' do
      expect(book.discounted?).to_not eq true
      expect(book1.discounted?).to eq true
    end
  end
end
