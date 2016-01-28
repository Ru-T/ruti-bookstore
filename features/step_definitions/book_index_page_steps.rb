Given(/^there are (\d+) books in the database$/) do |number|
  FactoryGirl.create_list(:book, 100)
end

Then(/^I see a list of books in the database$/) do
  expect(Book.all.ids).to include (1...100)
end

Then(/^the books are ordered by published date$/) do
  expect(Book.first).to eq Book.order(:published_date).first
  expect(Book.last).to eq Book.order(:published_date).last
end

Then(/^the list of (\d+) books are paginated in pages of (\d+) books per page$/) do |number_of_books, number_of_pages|
  expect(page).to have_link("View Book", count: 25)
  find("//*[@class='pagination']//a[text()='2']").click
  expect(page).to have_link("View Book", count: 25)
  find("//*[@class='pagination']//a[text()='3']").click
  expect(page).to have_link("View Book", count: 25)
  find("//*[@class='pagination']//a[text()='4']").click
  expect(page).to have_link("View Book", count: 25)
end

When(/^I enter a book's title into the book search field$/) do
  fill_in 'Title contains', with: Book.find(1).title
end

Then(/^I am shown a list of books with that title$/) do
  expect(page).to have_content(Book.find(1).title)
end
