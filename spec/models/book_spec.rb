require 'rails_helper'

RSpec.describe Book, type: :model do

  let(:book) { FactoryGirl.create(:book) }
  let(:book1) { create(:book) }

  describe "validations" do
    it "is valid without category or description" do
      expect(FactoryGirl.build(:book)).to be_valid
    end

    it "must have title to be valid" do
      expect(FactoryGirl.build(:book, title: "")).to_not be_valid
    end

    it "must have published_date to be valid" do
      expect(FactoryGirl.build(:book, published_date: nil)).to_not be_valid
    end

    it "must have author to be valid" do
      expect(FactoryGirl.build(:book, author: "")).to_not be_valid
    end

    it "must have price to be valid" do
      expect(FactoryGirl.build(:book, price: nil)).to_not be_valid
    end
  end

  describe '.default scope' do
    it 'orders by most recently published' do
      book2 = FactoryGirl.create(:book)
      expect(Book.first).to eq book2
    end
  end

end
