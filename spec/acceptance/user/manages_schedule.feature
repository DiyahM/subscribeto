Feature: User manages schedule
  In order plan my time and work for the week
  As a user
  I want to be able input my delivery and production orders for the week

  Scenario: User inputs schedule for the week
    Given I am logged in
    And I have customer 'Happy Grocer' assigned to delivery slot 'Monday at 9'
    And I have customer 'Friendly Grocer' assigned to delivery slot 'Tuesday at 9'
    And I have items 'Apple Smoothie, Banana Smoothie'
    When I visit 'dashboard'
    And I enter order '5' of 'Apple Smoothie' for 'Happy Grocer' at 'Monday 9:00'
    And I click 'Save'
    Then I should see 'Invoice Memo'
    And I should see 'Happy Grocers'
    And I should not see 'Friendly Grocers'
