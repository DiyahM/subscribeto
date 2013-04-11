Feature: Seller creates account

  @person_creates_account
  Scenario: Seller creates account as a person
    Given I don't already have an account
    When I visit '/'
    And I click 'Sign Up'
    And I fill in 'Name' with 'Donald Duck'
    And I fill in 'Email' with 'donald@duck.com'
    And I fill in 'Password' with 'password'
    And I fill in 'Password confirmation' with 'password'
    And I click 'Next'
    Then I should see 'Welcome Donald Duck'
    And I should see 'Lets Get Started'
    And I should see 'Are you selling your products as a person or business?'
    Then I choose 'person' on new account form
    And I click 'Next'
    And I fill in 'Phone number' with '5553332345'
    And I fill in 'EIN' with '1234'
    And I fill in 'Date of Birth' with '1979-08'
    And I fill in 'Street address' with '555 Harrison St'
    And I fill in 'City' with 'San Francisco'
    And I fill in 'Postal code' with '94114'
    And I click 'Next'
    Then I should see 'Which account would you like to receive your payments?'
