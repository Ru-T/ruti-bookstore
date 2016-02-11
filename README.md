# Description

This is a bookstore app. Users can sign up to view available books. Upon selecting a book, users can add any quantity of that book to their cart. When the user's cart is ready, a user can purchase the cart items.

## Details

Users can take the following actions in this bookstore app:

* View a table of the entire book inventory, including:
  - Title
  - Author  
  - Published date
  - Price
  - Discount price (if applicable)
  - Category
  - Description
* On the table view:
  - Sort by most popular books
  - Sort by title, published date, author, price, and category
  - Search by title or any word inside a title
* A view of any individual book and its details
* Add a book with any quantity to a user's cart
* View cart with all line_items, including quantity and discount price (if applicable)
* Purchase line_items in the user's cart, using a saved credit card (if applicable)
* Forget and reset password

## Admin Interface

Admin users can take the following actions in the admin interface of this bookstore app:

* View a dashboard of recent books and orders
* View all books and each book individually
* View all orders with their line items
* Edit any book, including adding a discount price in either dollar or percentage amount
* Create a new book
* Delete any book in the inventory
* View and create other admin users

## Test Coverage

* Model methods are covered with unit tests
* Full integration test suite using cucumber, capybara and selenium webdriver

## Database Structure

![alt tag](https://github.com/smashingboxes/ruti-bookstore/blob/admin_abilities/bookstore_database.png)
