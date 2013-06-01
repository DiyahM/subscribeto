Feature: Seller edits customer information

  Scenario: Seller edits customer information
    Given I am logged in
    Given I have a customer named 'Goofy Markets'
    When I click 'Customers'
    And I click the 'Edit' link for 'Goofy Markets'
    And I select 'Net 10' for 'customer[term]'
    And I click 'Save'
    Then I should see 'Customer was successfully updated'
