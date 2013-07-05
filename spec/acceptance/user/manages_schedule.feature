Feature: User manages schedule
  In order plan my time and work for the week
  As a user
  I want to be able input my delivery and production orders for the week

  Scenario: User inputs schedule for the week
    Given I am logged in
    And I have customers named 'Happy Grocers, Friendly Grocers'
    And I have delivery slot 'Monday at 9'
    And I have items 'Apple Smoothie, Banana Smoothie'
    When I visit 'dashboard'
    And I enter '5' for 'Qty Ordered' for 'Apple Smoothie' for 'Monday 9am'
    And I click 'Save'
    Then I should see 'Order Saved for the Week'
    And I should see 'This week's invoices'
