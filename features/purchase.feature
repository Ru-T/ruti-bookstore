Feature: Purchasing a Book
  Scenario: Quantity adjustment
    Given I am logged into the site
    And there are some books in the database
    When I visit the public book index
    And I click the Add to cart button for the first book
    Then the book is added to my cart with quantity 1
    When I adjust the quantity of the book to 3
    Then I see the book in my cart with quantity 3
