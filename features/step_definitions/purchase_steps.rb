Given(/^there are "(.*?)" books in the database$/) do |number|
  FactoryGirl.create_list(:book, number.to_i)
end

Given(/^there are some books in the database$/) do
  @book = FactoryGirl.create(:book, title: "A book")
  FactoryGirl.create(:book, title: "Another book")
  FactoryGirl.create(:book, title: "Yes another book")
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

Then(/^I see the book in my cart$/) do
  click_on "My Cart"
  expect(page).to have_content "A book"
end

Then(/^I am asked for my email address$/) do
  within_frame "stripe_checkout_app" do
    fill_in "Email", with: "newuser@test.com"
  end
end

Then(/^I am asked for my shipping address$/) do
  within_frame "stripe_checkout_app" do
    find(".same-address").click
  end
end

When(/^I enter my shipping address$/) do
  within_frame "stripe_checkout_app" do
    fill_in "Name", with: "New User"
    fill_in "Address", with: "Address"
    fill_in "ZIP", with: "27701"
  end
end

Then(/^I am asked for my billing address$/) do
  within_frame "stripe_checkout_app" do
    find(".segmentedControlItem1").click
  end
end

When(/^I enter my billing address$/) do
  within_frame "stripe_checkout_app" do
    fill_in "Name", with: "New User"
    fill_in "Address", with: "Address"
    fill_in "ZIP", with: "27701"
    click_on "Payment Info"
  end
end

Then(/^I am asked for my credit card$/) do
end

When(/^I enter my credit card$/) do
  within_frame "stripe_checkout_app" do
    "4242424242424242".split("").each { |c| find_field("card_number").native.send_keys(c) }
    "1218".split("").each { |c| find_field("cc-exp").native.send_keys(c) }
    fill_in "CVC", with: "111"
  end
end

When(/^I click the Submit Order button$/) do
  within_frame "stripe_checkout_app" do
    click_on "Submit Order"
  end
end

Then(/^I am asked to review the order total$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I am shown the order summary$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^my credit card is saved for future purchases$/) do
  expect(@user.stripe_customer_token).to_not be_nil
end

Then(/^I am emailed an order invoice containing the books details, quantity, subtotal, and order total$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I have a credit card saved on the site$/) do
  Stripe::Token.create(
    card: {
      number: "4242424242424242",
      exp_month: 12,
      exp_year: 2018,
      cvc: "111",
      address_line1: Faker::Address.street_address,
      address_city: Faker::Address.city,
      address_zip: Faker::Address.postcode,
      address_country: "United States"
    },
  )
end

Then(/^I am asked if I want to use my already saved credit card$/) do
  within_frame "stripe_checkout_app" do
    expect(frame).to_have content("Log out")
  end
end

When(/^I confirm using my saved credit card$/) do
  within_frame "stripe_checkout_app" do
    click_on "Submit Order"
  end
end
