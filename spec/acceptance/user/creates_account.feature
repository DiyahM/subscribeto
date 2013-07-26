Feature: User creates account

  @user_creates_account
  Scenario: User creates account
    Given I don't already have an account
    When I visit 'signup'
    And I fill in 'Company Name' with 'Duck Inc'
    And I fill in 'Your Name' with 'Donald Duck'
    And I fill in 'Email' with 'donald@duck.com'
    And I fill in 'Password' with 'password'
    And I fill in 'Password Confirmation' with 'password'
    And I click 'Sign Up'
    Then I should see '3 Steps To Get Started'

  Scenario: User first time login
    Given I don't already have an account
    When I visit 'signup'
    And I fill in 'Company Name' with 'Daffy Inc'
    And I fill in 'Your Name' with 'Daffy Duck'
    And I fill in 'Email' with 'daffy@duck.com'
    And I fill in 'Password' with 'password'
    And I fill in 'Password Confirmation' with 'password'
    And I click 'Sign Up'
    Then I should see '3 Steps To Get Started'
    And I should see 'Add available items for sale'
    And I should see 'Add your delivery schedule'
    And I should see 'Add one or more customers'
    And I should not see 'Update Orders' 
