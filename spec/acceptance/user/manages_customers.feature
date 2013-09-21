Feature: User manages customers

  Scenario: User creates customer
    Given I am logged in
    When I click 'Manage'
    And I click 'Customers'
    And I click '+ Add Customer'
    And I fill in 'customer[company_name]' with 'Happy Organics'
    And I fill in 'customer[poc_name]' with 'Lindsey Jones'
    And I fill in 'customer[email]' with 'lindsey@happy.com'
    And I click 'Save'
    Then I should see 'Happy Organics'
    Then I should see 'Lindsey Jones'
    Then I should not see 'Add New Customer'


  Scenario: Seller edits customer information
    Given I am logged in
    Given I have customer named 'Goofy Markets'
    When I click 'Customers'
    And I click the 'Edit' link for 'Goofy Markets'
    And I select 'Net 10' for 'customer[term]'
    And I click 'Save'
    Then I should see 'Customer was successfully updated'

  Scenario: User archives a customer
    Given I am logged in
    Given I have customers named 'Pear Farms, Plum Farms'
    When I click 'Customers'
    And I click the 'Archive' link for 'Plum Farms'
    Then I should see 'Customer has been archived'
    And I should see 'Pear Farms'
    And I should not see 'Plum Farms'


