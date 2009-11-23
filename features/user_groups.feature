Feature: 使用者與團體間的關係

  這個軟體是用來讓團體或公司專門用來管帳用。

  使用者可以瀏覽所有團體名稱。
  使用者可以利用名稱，短名搜尋所有團體。
  使用者可以加入團體，但是需要管理者的同意。
  使用者可以瀏覽已加入，且被同意的團體。(done)
  使用者加入團體，並且被同意後，才可以報帳到這個團體中。
  使用者可以unfollow某個已加入的團體。

  使用者可以新增類別到已加入且被核可的團體中。
  使用者報帳的時候可以選擇團體所屬的類別。
  使用者可以瀏覽團體總帳，包含日結、週結、月結。
  使月者可以瀏覽團體中其他成員的帳。

  要記錄每天的貨幣轉換


  Scenario: 我可以看到我所追蹤的所有團體
    Given I am logged in as "weijen" 
    When I go to the home page 
    Then I should see "Groups I followed"

  Scenario: 使用者可以加入團體
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    When I go to show group
    And I press "Join"
    Then I should see "join but not proven"
    And I join this group but not proven

  Scenario: 如果我是這個團體的管理員，我不應該看到join button
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    When I go to show group
    Then I should not see "Join" button  

  Scenario: 如果我已經加入這個團體了，我不應該看到join button
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    When I go to show group
    And I press "Join"
    Then I go to show group
    And I should not see "Join" button  
