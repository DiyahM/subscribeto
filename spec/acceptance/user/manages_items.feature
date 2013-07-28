Feature: User manages items
  Scenario: User creates an item
    Given I am logged in
    When I click 'Manage'
    And I click 'Items'
    And I click '+ Add Item For Sale'
    And I fill in 'Name' with 'Awesome Applesauce'
    And I fill in 'Price' with '5.00'
    And I click 'Save'
    Then I should see 'Awesome Applesauce'

  Scenario: User edits an item
    Given I am logged in
    And I have items 'Onions'
    When I click 'Manage'
    And I click 'Items'
    And I click the 'Edit' link for 'Onions'
    And I fill in 'Price' with '1.00'
    And I click 'Save'
    Then I should see '1.00'

  Scenario: User archives an item
    Given I am logged in
    And I have items 'Onions, Peppers'
    When I click 'Manage'
    And I click 'Items'
    And I click the 'Archive' link for 'Onions'
    Then I should see 'Item has been archived'
    And I should see 'Peppers'
    And I should not see 'Onions'
