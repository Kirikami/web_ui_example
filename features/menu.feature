Feature: Menu
  In order be able wot work with my account
  As a end user
  I want to be able to use menu

  Scenario: Sign out
    Given I am on LoginPage page
    When I submit valid credentials
    And I sign out
    Then I should not see HomePage page
    And I should see LoginPage page