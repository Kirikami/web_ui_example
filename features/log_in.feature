Feature: Log in
  In order to use kountable service
  As a end user
  I want to log in

  Scenario: Sign in as valid user
    Given I am on HomePage page
    When I navigate to sign_in page
    And I submit valid credentials
    Then I should see DashboardPage page

  Scenario: Sign in as invalid user
    Given I am on LoginPage page
    When I submit invalid credentials
    Then I should not see DashboardPage page
    And On LoginPage I should see error message

  Scenario: Sing in with empty fields
    Given I am on LoginPage page
    When I submit empty credentials
    Then I should not see DashboardPage page
    And On LoginPage I should see error message

  Scenario: Open forgot password form
    Given I am on LoginPage page
    When I click on forgot password button
    Then I should see forgot password form

  Scenario: Open forgot password form
    Given I am on LoginPage page
    When I click on forgot password button
    And I send reset email from forgot password form
    Then I should see successful message