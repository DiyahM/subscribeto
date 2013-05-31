Feature: User creates account

  @user_creates_account
  Scenario: User creates account
    Given I don't already have an account
    When I visit '/signup'
    And I fill in 'Company Name' with 'Duck Inc'
    And I fill in 'Your Name' with 'Donald Duck'
    And I fill in 'Email' with 'donald@duck.com'
    And I fill in 'Password' with 'password'
    And I fill in 'Password Confirmation' with 'password'
    And I click 'Sign Up'
    Then I should see 'Thank you for signing up. Get started by completing your profile'
    
