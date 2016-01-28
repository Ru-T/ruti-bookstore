Given(/^there are some books in the database$/) do
  FactoryGirl.create_list(:book, 100)
end

When(/^I click the "(.*?)" button for the first book$/) do |button|
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
