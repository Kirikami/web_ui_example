Feature: New deal
  In order to receive service
  As a end user
  I want to be able to add new deal

  Background: Log in
    Given I am on LoginPage page
    And I submit valid credentials
    Then I should see HomePage page

  Scenario: Add new deal
    When I click on add new deal
    And I submit random reseller information
    And I submit payor information
    And I submit supplier information
    Then I should see information review
    When I submit deal
    Then I should see congratulations screen
    When I am on HomePage page
    Then I should see new added deal

