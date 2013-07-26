Feature: User sets up account
  Scenario: User does not have any items
    Given I am logged in
    And I do not have any items
    When I visit 'dashboard'
    Then I should see '3 Steps To Get Started'
    And I should not see 'Update Orders'

  Scenario: User does not have any customers
    Given I am logged in
    Given I do not have any customers
    When I visit 'dashboard'
    Then I should see '3 Steps To Get Started'
    And I should not see 'Update Orders'

  Scenario: User does not have any delivery slots
    Given I am logged in
    Given I do not have any delivery slots
    When I visit 'dashboard'
    Then I should see '3 Steps To Get Started'
    And I should not see 'Update Orders'

  Scenario: User has completed setup of account
    Given I am logged in
    Given I have items "Apples, Pears"
    Given I have delivery slot "Monday at 11"
    Given I have customers named "Bob, Tina, Mark"
    When I visit 'dashboard'
    Then I should see 'Update Orders'
    And I should see 'Send Invoices'
    And I should see 'Summary Report'
