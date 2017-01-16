Feature: My deals
  In order to review all my deals
  As a end user
  I want to see all my deals on page

  Background: Log in
    Given I am on LoginPage page
    And I submit valid credentials
    Then I should see HomePage page

    Scenario: Open my deal
      When I click on random deal
      Then I should see documents on deal page

    Scenario: Add attachment to document
      When I click on random deal
      And I open random document
      And I add attachment to document
      Then I should see attachment in document