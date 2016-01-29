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

Then(/^the book is added to my cart$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I see the book in my cart$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I am asked for my shipping address$/) do
  check "Same billing & shipping info"
  expect(page).to have_content "Shipping"
end

When(/^I enter my shipping address$/) do
  fill_in "Name", with: "New User"
  fill_in "Address", with: "Address"
  fill_in "ZIP", with: "27701"
end

Then(/^I am asked for my billing address$/) do
  expect(page).to have_content "Shipping"
end

When(/^I enter my billing address$/) do
  click_on "Billing"
  fill_in "Address", with: "Address"
  fill_in "ZIP", with: "27701"
  click_on "Payment Info"
end

Then(/^I am asked for my credit card$/) do
  expect(page).to have_content "Card number"
end

When(/^I enter my credit card$/) do
  fill_in "Card number", with: "4242424242424242"
  fill_in "MM / YY", with: "12/18"
  fill_in "CVC", with: "111"
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
