Feature: Editing user information
  In order to change my information
  As a end user
  I want have functionality to edit my personal information

  Background: Log in
    Given I am on LoginPage page
    And I submit valid credentials
    Then I should see DashboardPage page

  Scenario: Edit name
    When I click on edit button for username
    And I change username to new
    Then I should see username changed
    When I change username to default
    Then I should see username changed

  Scenario: Edit address information
    When I click on edit button for address
    And I change address to new
    Then I should see address changed
    When I change address to default
    Then I should see address changed