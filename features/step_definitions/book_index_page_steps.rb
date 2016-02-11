Given(/^there are (\d+) books in the database$/) do |number|
  FactoryGirl.create_list(:book, number.to_i)
end

Then(/^I see a list of books in the database$/) do
  expect(Book.all.ids).to include (1...100)
end

Then(/^the books are ordered by published date$/) do
  expect(page).to have_content(/#{Book.first.title}.*#{Book.fifth.title}/m)
end

Then(/^the list of 100 books are paginated in pages of 25 books per page$/) do
  expect(page).to have_link("View Book", count: 25)
  find("//*[@class='pagination']//a[text()='2']").click
  expect(page).to have_link("View Book", count: 25)
  find("//*[@class='pagination']//a[text()='3']").click
  expect(page).to have_link("View Book", count: 25)
  find("//*[@class='pagination']//a[text()='4']").click
  expect(page).to have_link("View Book", count: 25)
end

When(/^I enter a book's title into the book search field$/) do
  fill_in 'Title contains', with: Book.first.title
end

Then(/^I am shown a list of books with that title$/) do
  expect(page).to have_content(Book.first.title)
end

Given(/^some books have been ordered$/) do
  Book.first.update(order_count: 2)
  Book.fifth.update(order_count: 3)
end

When(/^I sort by "([^"]*)"$/) do |sort|
  click_on sort
end

Then(/^the books are re\-sorted based on the amount of times they are purchased$/) do
  expect(page).to have_content(/#{Book.first.title}.*#{Book.fifth.title}/m)
end
