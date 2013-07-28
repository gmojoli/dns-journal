Feature: Manage domains
  In order to manage a dns file
  As an user
  I want to create and manage domains

  Scenario: Domains List
    Given I have domains named foo.com, bar.com
    When I go to the list of domains
    And authenticate
    Then I should see "foo.com"
    And I should see "bar.com"