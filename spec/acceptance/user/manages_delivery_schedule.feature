Feature: User manages delivery schedule
  Scenario: User creates a delivery route
    Given I am logged in
    When I click 'Manage'
    And I click 'Delivery Schedule'
    And I click '+ Add Delivery Route'
    And I select 'Monday' for 'Day of the Week'
    And I fill in 'Delivery Time' with '08:00AM'
    And I click 'Create'
    Then I should see 'Monday 8:00'

  Scenario: User deletes a delivery route
    Given I am logged in
    And I have delivery slot 'Monday at 8'
    When I click 'Manage'
    And I click 'Delivery Schedule'
    And I click the 'Remove' link for 'Monday 8:00'
    Then I should not see 'Monday 8:00'
