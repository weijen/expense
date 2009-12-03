Feature: 團體的的操作

  (done)使用者可以新增一個團體，而這個使用者就必然是這個團體的管理員。
  (done)管理員可以修改團體的資料，或者刪除團體。
  團體應該有開始時間與結束時間

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

 
