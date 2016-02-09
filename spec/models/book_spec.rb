require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:book) { create(:book) }
  let(:book1) { create(:book) }
  let(:line_item) { create(:line_item, cart: cart, book: book1, order: nil) }
  let(:order) { create(:order, user: user) }

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

  describe '#number_sold' do
    it 'returns the number of times a book sold' do
      expect(cart.line_items).to include line_item
      order.purchase_line_items
      expect(order.reload.line_items).to include line_item
      expect(cart.reload.line_items).to be_empty
      expect(book.number_sold).to eq 0
      expect(book1.number_sold).to eq 1
    end
  end

  describe '.most_popular' do
    it 'orders by most popular' do
      expect(cart.line_items).to include line_item
      order.purchase_line_items
      expect(order.reload.line_items).to include line_item
      expect(cart.reload.line_items).to be_empty
      expect(book.number_sold).to eq 0
      expect(book1.number_sold).to eq 1
      expect(Book.all.most_popular).to eq [book1, book]
    end
  end
end
