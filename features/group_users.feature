Feature: 團體對會員的關係

  Scenario: 管理者可以邀請某個會員，這個會員直接就approved了
    Given I am logged in as "weijen"
    And a group named "FooGroup" is belongs to me
    And an user with attributes:
      |login|password|email|
      | allen | foobar | allen@example.com |
    When I go to new_group_user_path
    And I fill in "user_email" 

  
  Scenario: 管理者可以看到目前follow這個團體的會員
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    And I go to show group
    When I follow "JoinedUsers"
    Then I should see "test_group users"

  Scenario: 管理者可以看到這個團體已approved的所有會員

  Scenario: 管理者可以approve某個會員
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    And a user "tina" want join this group 
    And I go to group users page
    When I follow "approve"
    And I should see "Approve user:"

  Scenario: 管理者可以踢掉某個已approved的會員
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    And a user "tina" is a approved user 
    And I go to group users page
    When I follow "remove"
    And I should see "Remove user:"

  Scenario: 管理者可以邀請某個會員，這個會員直接就approved了

  Scenario: 管理員可以指定其他人為管理員
