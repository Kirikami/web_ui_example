Feature: Log in
  In order to use kountable service
  As a end user
  I want to log in

  Scenario: Sign in as valid user
    Given I am on LoginPage page
    When I submit valid credentials
    Then I should see DashboardPage page

  Scenario: Sign in as invalid user
    Given I am on LoginPage page
    When I submit invalid credentials
    Then I should not see DashboardPage page
    And On LoginPage I should see credentials error message

  Scenario: Sing in with empty fields
    Given I am on LoginPage page
    When I submit empty credentials
    Then I should not see DashboardPage page
    And On LoginPage I should see input error message

  Scenario: Open forgot password form
    Given I am on LoginPage page
    When I click on forgot password button
    Then I should see forgot password form

  Scenario: Open forgot password form
    Given I am on LoginPage page
    When I click on forgot password button
    And I send reset email from forgot password form
    Then I should see ForgotPasswordSuccess page url
    And I should see forgot password successful message
