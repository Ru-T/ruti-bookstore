Given(/^I have an admin account$/) do
  FactoryGirl.create(:admin_user)
end

When(/^I visit the admin panel url$/) do
  visit new_admin_user_session_path
end

When(/^I enter my admin email$/) do
  fill_in 'Email', with: 'admin@example.com'
end

When(/^I enter my admin password$/) do
  fill_in 'Password', with: 'password'
end

Then(/^I see the admin panel$/) do
  visit admin_root_path
end

Given(/^I do not have an admin account$/) do
end

Then(/^I see a flash notification that tell me that my email does not exist in the system$/) do
  expect(page).to have_content("Invalid email or password.")
end

Given(/^I am logged into the admin panel$/) do
  FactoryGirl.create(:admin_user)
  visit new_admin_user_session_path
  fill_in 'Email', with: 'admin@example.com'
  fill_in 'Password', with: 'password'
  click_on "Login"
end

Given(/^I am logged into the site$/) do
  user = FactoryGirl.create(:user, email: "ruti@test.com", confirmed_at: Date.current)
  visit root_path
  fill_in "Email", with: "ruti@test.com"
  fill_in "Password", with: "password"
  click_on "Log in"
end

When(/^I visit the admin books url$/) do
  visit admin_books_path
end

When(/^I enter the title "(.*?)"$/) do |title|
  fill_in 'Title', with: title
end

When(/^I enter the price "(.*?)"$/) do |price|
  fill_in "Price", with: price
end

And(/^I select the date "([^"]*)" for "(.*?)"$/) do |in_date_str, field|
  def select_date(date, options = {})
    date = Date.parse(date) if date.class == String
    field = options[:from]
    base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]

    year_format = options[:year_format] || '%Y'
    year = date.strftime(year_format)

    month_format = options[:month_format] || '%B'
    month = date.strftime(month_format)

    day_format = options[:day_format] || '%-d'
    day = date.strftime(day_format)

    select year,  from: "book_published_date_1i"
    select month, from: "book_published_date_2i"
    select day,   from: "book_published_date_3i"
  end
  select_date(in_date_str, from: field)
end

When(/^I enter the author "(.*?)"$/) do |author|
  fill_in "Author", with: author
end

Then(/^I see the book "(.*?)"$/) do |title|
  expect(page).to have_content(title)
end

When(/^I visit the public book index$/) do
  visit books_path
end

Then(/^I see the book published date "(.*?)"$/) do |published_date|
  expect(page).to have_content(published_date)
end

Then(/^I see the book author "(.*?)"$/) do |author|
  expect(page).to have_content(author)
end

And(/^there is a book named "(.*?)"$/) do |title|
  @book = FactoryGirl.create(:book, title: title)
end

When(/^I click the delete link for the book "(.*?)"$/) do |link|
  find("#book_#{@book.id}").find(".delete_link").click
end

When(/^I click the edit link for the book "(.*?)"$/) do |link|
  find("#book_#{@book.id}").find(".edit_link").click
end

Then(/^I see a prompt requesting that I confirm my decision to delete the book$/) do
  page.driver.browser.switch_to.alert.text
end

When(/^I confirm my decision to delete the book$/) do
  page.driver.browser.switch_to.alert.accept
end

Then(/^I don't see "(.*?)"$/) do |title|
  expect(page).not_to have_content(title)
end

Given(/^the book is valued at "(.*?)"$/) do |price|
  FactoryGirl.create(:book, price: price)
end

When(/^I change the book name to "(.*?)"$/) do |new_title|
  fill_in 'Title', with: new_title
end

When(/^I change the book price to "(.*?)"$/) do |new_price|
  fill_in 'Price', with: new_price
end
