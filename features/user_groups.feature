Feature: 使用者與團體間的關係

  這個軟體是用來讓團體或公司專門用來管帳用。

  使用者可以新增一個團體，而這個使用者就必然是這個團體的管理員。
  管理員可以修改團體的資料，或者刪除團體。

  使用者可以瀏覽團體名稱。
  使用者可以利用名稱，短名搜尋團體。
  使用者可以加入團體，但是需要管理者的同意。
  使用者加入團體，並且被同意後，才可以報帳到這個團體中。


  Scenario: 新增團體
    Given a user is logged in as "weijen" 
    When I visit groups/new
    And I inpus group's name and short name
    And I sumbit
    Then show group's profile
    And I'm the manager of this group
