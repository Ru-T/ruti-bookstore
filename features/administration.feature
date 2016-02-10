Feature: Bookstore Administration Panel
  Scenario: Admin Authentication
    Given I have an admin account
    When I visit the admin panel url
    And I enter my admin email
    And I enter my admin password
    And I click the "Login" button
    Then I see the admin panel

  Scenario: Invalid Login
    Given I do not have an admin account
    When I visit the admin panel url
    And I enter my admin email
    And I enter my admin password
    And I click the "Login" button
    Then I see a flash notification that tell me that my email does not exist in the system

  Scenario: Adding a book
    Given I am logged into the admin panel
    And I am logged into the site
    When I visit the admin books url
    And I click the "New Book" button
    And I enter the title "Test Book"
    And I enter the price "135.99"
    And I select the date "2016-01-26" for "Published date"
    And I enter the author "Some Person"
    And I click the "Create Book" button
    And I visit the admin books url
    Then I see the book "Test Book"
    When I visit the public book index
    Then I see the book "Test Book"
    And I see the book published date "2016-01-26"
    And I see the book author "Some Person"

  @javascript
  Scenario: Deleting a book
    Given I am logged into the admin panel
    And I am logged into the site
    And there is a book named "Book To Be Deleted"
    When I visit the admin books url
    And I click the delete link for the book "Book To Be Deleted"
    Then I see a prompt requesting that I confirm my decision to delete the book
    When I confirm my decision to delete the book
    Then I don't see "Book To Be Deleted"
    When I visit the public book index
    Then I don't see "Book To Be Deleted"

  Scenario: Editing a book
    Given I am logged into the admin panel
    And I am logged into the site
    And there is a book named "Book To Be Edited"
    And the book is valued at "$135.99"
    When I visit the admin books url
    And I click the edit link for the book "Book To Be Edited"
    And I change the book name to "Book That Has Been Edited"
    And I change the book price to "222.22"
    And I click the "Update Book" button
    And I visit the admin books url
    Then I see the book "Book That Has Been Edited"
    When I visit the public book index
    Then I see the book "Book That Has Been Edited"

  Scenario: Viewing orders
    Given I am logged into the admin panel
    And there are 100 books in the database
    And some books have been ordered
    When I visit the admin orders url
    Then I see the orders

  Scenario: Adding a book discount
    Given I am logged into the admin panel
    And I am logged into the site
    And there is a book named "Book To Be Discounted"
    And the book is valued at "$20.00"
    When I visit the admin books url
    And I click the edit link for the book "Book To Be Discounted"
    And I change the book discount to "3.50"
    And I click the "Update Book" button
    And I visit the admin books url
    Then I see the book has the discount "$3.50"
    When I visit the public book index
    Then I see the book has the discount price "$16.50"
    Then I visit the admin books url
    And I click the edit link for the book "Book To Be Discounted"
    And I change the book discount to 20 percent
    And I click the "Update Book" button
    And I visit the admin books url
    Then I see the book has the discount "$4.00"
    When I visit the public book index
    Then I see the book has the discount price "$16.00"
