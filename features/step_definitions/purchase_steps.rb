Given(/^there are some books in the database$/) do
  FactoryGirl.create_list(:book, 100)
end

When(/^I click the "(.*?)" button for the first book$/) do |button|
  find("#new_pending_purchase".first).click
end

When(/^I enter (\d+) for the quantity$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the book is added to my cart with quantity (\d+)$/) do |quantity|
  pending # express the regexp above with the code you wish you had
end

When(/^I visit my cart$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I see the book in my cart with quantity (\d+)$/) do |quantity|
  pending # express the regexp above with the code you wish you had
end

When(/^I adjust the quantity of the book to (\d+)$/) do |quantity|
  pending # express the regexp above with the code you wish you had
end
