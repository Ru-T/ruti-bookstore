require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

  describe '#pending_purchase' do
    it "allows a user to add a book to his/her cart" do
      user.pending_purchase(book)
      expect(user.pending_purchases.last.book_id).to eq book.id
    end
  end
end
