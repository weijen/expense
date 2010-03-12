Feature: 團體的的操作

  (done)使用者可以新增一個團體，而這個使用者就必然是這個團體的管理員。
  (done)管理員可以修改團體的資料，或者刪除團體。
  (done)管理員可以凍結團體，就不再接受報帳了
  管理員可以凍結報帳時間，不再接受那個時間之前的報帳

  Scenario: 新增團體的正常狀況
    Given I am logged in as "weijen" 
    When I go to groups/new 
    And I fill in "group_name" with "group_name"
    And I fill in "group_short_name" with "group_short_name"
    And I press "Create" 
    Then A group named "group_name" should be created
    And I should be on show group
    And I am the manager of this group

  Scenario: 新增團體時，沒有填入團體名稱，會有錯誤訊息
    Given I am logged in as "weijen"
    When I go to groups/new
    And I fill in "group_short_name" with "test_short_name"
    And I press "Create"
    Then I should see "Name can't be blank" 

  Scenario: 新增團體時，團體名稱小於3個字元，會有錯誤訊息
    Given I am logged in as "weijen"
    When I go to groups/new
    And I fill in "group_short_name" with "group_short_name"
    And I press "Create"
    Then I should see "Name is too short (minimum is 3 characters)" 

  Scenario: 新增團體時，沒有填入團體簡稱，會有錯誤訊息
    Given I am logged in as "weijen"
    When I go to groups/new
    And I fill in "name" with "group_name"
    And I press "Create"
    Then I should see "Short name can't be blank"

  Scenario: 我是這個團體的管理員，我可以修改團體資料
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    When I go to groups/edit
    And I fill in "name" with "test_edit_group"
    And I press "Update"
    Then the group name become "test_edit_group"

  Scenario: 我不是這個團體的管理員，我不可以修改團體資料
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    When I go to groups/edit
    Then I should see "You have no right to access this page" 
    And I should be on the home page

  Scenario: 我是這個團體的管理員，我可以凍結團體
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    When I go to show group
    And I follow "Freeze"
    Then I should see "This group was frozen"
    And I should not see "Freeze"
    And I should see "Alive"

  Scenario: 我是這個團體的管理員，我可以解凍團體
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    And this group was frozen
    When I go to show group
    And I follow "Alive"
    And I should not see "Alive"
    And I should see "Freeze"

  Scenario: 我可以瀏覽屬於我的團體
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    When I go to groups_path
    Then I should see "test_group"
  
  Scenario: 我可以瀏覽我有被邀請的團體
    Given I am logged in as "weijen"
    And a group named "group not belong to me" is not belongs to me
    And I am an approved user for this group
    When I go to groups_path
    Then I should see "group not belong to me"

  Scenario: 我不可以瀏覽我沒被邀請的團體
    Given I am logged in as "weijen"
    And a group named "group not belong to me" is not belongs to me
    When I go to groups_path
    Then I should not see "group not belong to me"

  @current
  Scenario: 如果我不屬於任何團體，有一個新增團體的連結給我選
    Given I am logged in as "weijen"
    When I go to groups_path
    Then I should see "You do not belong to any group"
