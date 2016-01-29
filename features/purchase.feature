Feature: Purchasing a Book
  Scenario: Happy Path
    Given I am logged into the site
    And there are some books in the database
    When I visit the site root path
    And I click the Add to cart button for the first book
    Then the book is added to my cart
    When I visit my cart
    Then I see the book in my cart
    When I click the "Purchase" button
    Then I am asked for my shipping address
    When I enter my shipping address
    Then I am asked for my billing address
    When I enter my billing address
    Then I am asked for my credit card
    When I enter my credit card
    And I click the "Submit Order" button
    Then I am asked to review the order total
    When I click the "Confirm" button
    Then I am shown the order summary
    Then my credit card is saved for future purchases
    And I am emailed an order invoice containing the books details, quantity, subtotal, and order total

  Scenario: Quantity adjustment
    Given I am logged into the site
    And there are some books in the database
    When I visit the public book index
    And I click the Add to cart button for the first book
    Then the book is added to my cart with quantity 1
    When I adjust the quantity of the book to 3
    Then I see the book in my cart with quantity 3

  Scenario: With a saved Credit Card
    Given I am logged into the site
    And there are some books in the database
    And I have a credit card saved on the site
    When I visit the site root path
    And I click the Add to cart button for the first book
    Then the book is added to my cart
    When I visit my cart
    Then I see the book in my cart
    When I click the "Purchase" button
    Then I am asked for my shipping address
    When I enter my shipping address
    Then I am asked if I want to use my already saved credit card
    When I confirm using my saved credit card
    Then I am asked to review the order total
    When I click the "Confirm" button
    Then I am shown the order summary
    And my credit card is saved for future purchases
    And I am emailed an order invoice containing the books details, quantity, subtotal, and order total
