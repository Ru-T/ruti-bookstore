Given(/^there are "(.*?)" books in the database$/) do |number|
  FactoryGirl.create_list(:book, number.to_i)
end

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

Then(/^the book is added to my cart$/) do
  # expect(@user.cart.line_items).to include book_id: @book.id
end

When(/^I enter (\d+) for the quantity$/) do |quantity|
  fill_in "Quantity", with: quantity
end

Then(/^the book is added to my cart with quantity (\d+)$/) do |quantity|
  expect(PendingPurchase.last.quantity).to eq quantity.to_i
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
  fill_in "Quantity", with: quantity
  click_on "Update Line Item"
end

Then(/^I see the book in my cart$/) do
  click_on "My Cart"
  expect(page).to have_content "A book"
end

Then(/^I am asked for my shipping address$/) do
  expect(page).to have_content "Shipping"
end

When(/^I enter my shipping address$/) do
  fill_in "Shipping address1", with: "Address"
  fill_in "Shipping city", with: "Durham"
  fill_in "Shipping state", with: "NC"
  fill_in "Shipping zip", with: "27701"
end

Then(/^I am asked for my billing address$/) do
  expect(page).to have_content "Billing"
end

When(/^I enter my billing address$/) do
  fill_in "Address", with: "Address"
  fill_in "City", with: "Durham"
  fill_in "ZIP", with: "27701"
end

Then(/^I am asked for my credit card$/) do
  expect(page).to have_content "Credit Card"
end

When(/^I enter my credit card$/) do
  fill_in "Credit Card", with: "4242424242424242"
  fill_in "CVV", with: "111"
end

When(/^I choose to have my credit card remembered$/) do
  find(".checkbox-remember-me").click
end

When(/^I click the Submit Order button$/) do
  click_on "Submit Order"
end

Then(/^I am asked to review the order total$/) do
  expect(page).to have_content("Review Purchase Order")
  expect(page).to have_content("A book")
end

Then(/^I am shown the order summary$/) do
  expect(page).to have_content("Order Summary")
end

Then(/^my credit card is saved for future purchases$/) do
  expect(@user.card_token).to_not be_nil
end

Then(/^I am emailed an order invoice containing the books details, quantity, subtotal, and order total$/) do
  ActionMailer::Base.deliveries.last.body.to_include("receipt")
end

Given(/^I have a credit card saved on the site$/) do
  expect(@user.card_token).to_not be_nil
end

Then(/^I am asked if I want to use my already saved credit card$/) do
  expect(page).to have_content("User your saved credit card?")
end

When(/^I confirm using my saved credit card$/) do
  click_on "Submit Order"
end
