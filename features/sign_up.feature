Feature: Log in
  In order to check kountable service
  As a end user
  I want to sign up

  Scenario: Sign in as valid user
    Given I am on HomePage page
    When I navigate to sign_up page
    And I register with valid credentials
    Then I should see HomePage page

  Scenario: Sign in as invalid user
    Given I am on SignUpPage page
    When I register with already_registered credentials
    Then I should not see HomePage page
    And On SignUpPage I should see registered error message