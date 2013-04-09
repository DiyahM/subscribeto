Feature: Seller creates account
  Scenario: Seller creates account
    Given I don't already have an account
    When I visit '/'
    And I click 'Sign Up'
    And I fill in 'Email' with 'Donald Duck'
    And I fill in 'Password' with 'password'
    And I fill in 'Password confirmation' with 'password'
    And I click 'Create an account'
    Then I should see 'Lets Get Started'
