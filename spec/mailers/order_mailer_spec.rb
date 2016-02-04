require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do

  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:cart) { create(:cart, user: user) }
  let(:order) { create(:order, user: user) }
  let(:line_item) { create(:line_item, cart: cart, book: book, order: nil) }

  describe "send order receipt to correct user" do
    it "sends order receipt to correct user" do
      order.purchase_line_items

      receipt = OrderMailer.receipt_email(user).deliver_now
      expect(ActionMailer::Base.deliveries).to_not be_empty

      expect(receipt.from).to eq ["receipt@bookstore.com"]
      expect(receipt.to).to eq [user.email]
      expect(receipt.subject).to eq "Your Order Has Been Completed"
    end
  end
end
