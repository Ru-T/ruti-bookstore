Given(/^there are some books in the database$/) do
  FactoryGirl.create_list(:book, 100)
end

When(/^I click the Add to cart button for the first book$/) do
  find("#add_to_cart", match: :first).click
end

When(/^I enter (\d+) for the quantity$/) do |quantity|
  fill_in "Quantity", with: quantity
end

Then(/^the book is added to my cart with quantity (\d+)$/) do |quantity|
  expect(PendingPurchase.last.quantity).to eq quantity.to_i
end

When(/^I visit my cart$/) do
  visit pending_purchases_path
end

Then(/^I see the book in my cart with quantity (\d+)$/) do |quantity|
  expect(page).to have_content(quantity)
  expect(PendingPurchase.last.quantity).to eq quantity.to_i
end

When(/^I adjust the quantity of the book to (\d+)$/) do |quantity|
  find("#edit_quantity", match: :first).click
  fill_in "Quantity", with: quantity
  click_on "Update Pending purchase"
end

When(/^I enter my billing address$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I am asked for my credit card$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter my credit card$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I am asked to review the order total$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I am shown the order summary$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^my credit card is saved for future purchases$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I am emailed an order invoice containing the books details, quantity, subtotal, and order total$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I have a credit card saved on the site$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I am asked if I want to use my already saved credit card$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I confirm using my saved credit card$/) do
  pending # express the regexp above with the code you wish you had
end
