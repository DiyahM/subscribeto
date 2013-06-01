Feature: User creates an item for sale
  Scenario: User creates an item for sale
    Given I am logged in
    When I click 'Manage'
    And I click 'Items'
    And I click '+ Add Item For Sale'
    And I fill in 'Name' with 'Awesome Applesauce'
    And I fill in 'Price' with '5.00'
    And I click 'Save'
    Then I should see 'Awesome Applesauce'
