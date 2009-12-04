Feature: 帳單的分類

  (done)登入的使用者可以建立新的支出分類
  (done)登入的使用者可以建立新的收入分類
  (done)分類的建立者可以有修改的連結，如果沒有帳單屬於這個分類
  (done)分類的建立者不可以有修改的連結，如果有帳單屬於這個分類
  (done)分類的建立者可以有刪除的連結，如果沒有帳單屬於這個分類
  (done)分類的建立者不可以有刪除的連結，如果有帳單屬於這個分類
  不可以刪除分類，如果有帳單屬於這個分類
  登入的使用者可以看到所有的分類

  Scenario Outline: 登入的使用者可以建立新的支出分類
    Given I am logged in as "<user>"
      And I go to new_tag_path
     When I fill in "name" with "<tag>"
      And I press "Create"
     Then There is a tag named "<tag>" in db
      And This tag is outgoing tag
      And This tag.user_id is my id

    Examples:
      | user | tag |
      | weijen | Test tag 1|
      | gugod | Test tag 2|
      | hlb | Test tag 3|

  Scenario: 登入的使用者可以建立新的收入分類
    Given I am logged in as "weijen"
      And I go to new_tag_path
     When I fill in "name" with "test_tag"
      And I check "income?"
      And I press "Create"
     Then There is a tag named "test_tag" in db
      And This tag is income tag
      And This tag.user_id is my id

  Scenario: 分類的建立者可以有修改的連結，如果沒有帳單屬於這個分類
    Given I am logged in as "weijen"
      And I create a "income" tag named "test_tag"
     When I am on tags_path 
     Then I should see "Edit"

  Scenario: 分類的建立者不可以有修改的連結，如果有帳單屬於這個分類
    Given I am logged in as "weijen"
      And a group named "test_group" is belongs to me 
      And I create a "outgoing" tag named "test_tag"
      And I create a expense belong to this tag
     When I am on tags_path 
     Then I should not see "Edit"

  Scenario: 分類的建立者可以有刪除的連結，如果沒有帳單屬於這個分類
    Given I am logged in as "weijen"
      And I create a "income" tag named "test_tag"
     When I am on tags_path 
     Then I should see "Destroy"

  Scenario: 分類的建立者不可以有刪除的連結，如果有帳單屬於這個分類
    Given I am logged in as "weijen"
      And a group named "test_group" is belongs to me 
      And I create a "outgoing" tag named "test_tag"
      And I create a expense belong to this tag
     When I am on tags_path 
     Then I should not see "Destroy"
