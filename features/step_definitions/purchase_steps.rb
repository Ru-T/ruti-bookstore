Given(/^there are some books in the database$/) do
  @book = FactoryGirl.create(:book, title: "A book")
  FactoryGirl.create(:book, title: "Another book")
  FactoryGirl.create(:book, title: "Yes another book")
end

When(/^I click on a book$/) do
  find("#view_book", match: :first).click
end

When(/^I click "([^"]*)"$/) do |link|
  click_on link
end

When(/^I enter (\d+) for the quantity$/) do |quantity|
  find("#edit_quantity").set quantity
end

Then(/^the book is added to my cart with quantity (\d+)$/) do |quantity|
  expect(LineItem.last.quantity).to eq quantity.to_i
end

When(/^I visit my cart$/) do
  visit cart_path(@user)
end

Then(/^I see the book in my cart with quantity (\d+)$/) do |quantity|
  expect(page).to have_content(quantity)
  expect(LineItem.last.quantity).to eq quantity.to_i
end

When(/^I adjust the quantity of the book to (\d+)$/) do |quantity|
  click_on "Edit Quantity"
  find("#edit_quantity").set quantity
  click_on "Update Line item"
end

Then(/^I see the book in my cart$/) do
  click_on "My Cart"
  expect(page).to have_content "A book"
end

Then(/^I am asked for my shipping address$/) do
  expect(page).to have_content "Shipping"
end

When(/^I enter a valid shipping address$/) do
  fill_in "Shipping address1", with: "Address"
  fill_in "Shipping city", with: "Durham"
  fill_in "Shipping state", with: "NC"
  fill_in "Shipping zip", with: "27701"
end

Then(/^I am asked for my billing address$/) do
  expect(page).to have_content "Billing"
end

When(/^I enter a valid billing address$/) do
  fill_in "Billing address1", with: "Address"
  fill_in "Billing city", with: "Durham"
  fill_in "Billing state", with: "NC"
  fill_in "Billing zip", with: "27701"
end

Then(/^I am asked for my credit card$/) do
  expect(page).to have_content "Credit Card"
end

When(/^I enter a valid credit card$/) do
  fill_in "Credit Card", with: "6011111111111117"
  fill_in "CVV", with: "111"
  select "7", from: "card-month"
  select "2018", from: "card-year"
end

When(/^I click the Submit Order button$/) do
  click_on "Submit Order"
end

Then(/^I am asked to review the order total$/) do
  expect(page).to have_content("Order Summary Review")
  expect(page).to have_content("A book")
end

Then(/^I am shown the order summary$/) do
  expect(page).to have_content("Order Confirmation")
end

Then(/^my credit card is saved for future purchases$/) do
  @order = Order.find_by(user: @user)
  expect(@order.credit_card.card_token).to_not be_nil
end

Then(/^I am emailed an order invoice containing the books details, quantity, subtotal, and order total$/) do
  expect(ActionMailer::Base.deliveries.last.body.encoded).to include "Book Title"
  expect(ActionMailer::Base.deliveries.last.body.encoded).to include "Quantity"
  expect(ActionMailer::Base.deliveries.last.body.encoded).to include "Total"
end

Given(/^I have a credit card saved on the site$/) do
  StripeMock.start
  stripe_helper = StripeMock.create_test_helper
  order = Order.create(user: @user, stripe_token: stripe_helper.generate_card_token)
  CreditCard.create(user: @user)
  order.save_card
  expect(order.credit_card.card_token).to_not be_nil
  StripeMock.stop
end

Then(/^I am asked if I want to use my already saved credit card$/) do
  expect(page).to have_content("Your credit card is stored on file.")
end

When(/^I confirm using my saved credit card$/) do
  StripeMock.start
  stripe_helper = StripeMock.create_test_helper
  order = Order.create(user: @user, stripe_token: stripe_helper.generate_card_token)
  CreditCard.create(user: @user)
  order.save_card
  click_on "Submit Order"
end
