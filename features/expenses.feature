Feature: 團體的帳目

帳目包含日期時間、團體、幣別、金額、類別、備註

(done)我可以報帳到我所follow的團體

我可以看到我所follow的團體的細帳

我可以看到我所follow的團體的日結、週結、月結（以幣別作分類)

我可以看到我所follow的團體的分類結算

我可以看到我所follow的團體的分類細項

在dashboard可以看到最近20筆，我所follow的團體的其他人的報帳

  Scenario Outline: 我是管理員，我可以新增帳單到我所follow的團體
    Given I am logged in as "weijen"
    And a group named <group> is belongs to me
    When I go to <path> 
    And I select <group> from "group"
    And I select <tag> from "tag"
    And I fill in "amount" with <amount> 
    And I press "Create"
    Then I should see "Expense was successfully created"

    Examples:
      | group | path | tag | amount |
      | "test_group" | new_income_path | "會員收費" | "100" |
      | "test_group" | new_outgoing_path | "差旅費" | "200" |

  Scenario Outline: 我是approved user，我可以新增帳單到我所follow的團體
    Given I am logged in as "weijen"
    And a group named "<group>" is not belongs to me
    And I follow this group and be approved
    When I go to <path>
    And I select "<group>" from "group"
    And I select "<tag>" from "tag"
    And I fill in "amount" with "<amount>" 
    And I press "Create"
    Then I should see "Expense was successfully created"

    Examples:
      | group | path | tag | amount |
      | test_group | new_income_path | 會員收費 | 100 |
      | test_group | new_outgoing_path | 差旅費 | 200 |

  Scenario Outline: 我是unapprove user，我無法選到我已經參與，但是還沒被approve的團體，在新增收入的時候
    Given I am logged in as "weijen"
    And a group named "<group>" is not belongs to me
    And I follow this group but still not to be approve
    When I go to <path>
    Then the "group" field should not contain "test_group"

    Examples:
      | group | path |
      | test_group | new_income_path | 
      | test_group | new_outgoing_path |


   Scenario Outline: 我無法選到我沒有參與的團體，在新增收入的時候
    Given I am logged in as "weijen"
    And a group named "<group>" is not belongs to me
    When I go to <path>
    Then the "group" field should not contain "test_group"

    Examples:
      | group | path |
      | test_group | new_income_path |
      | test_group | new_outgoing_path |

  @here
  Scenario: 我是approved user，我可以瀏覽某一段日期的人員開支報表
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    And I follow this group and be approved
    And There are 10 users joined to "test_group" 
    And There are 100 expenses belongs to "test_group" 
    When I go to show group 
    And I fill in "start_date" with "2009-11-01"
    And I fill in "end_date" with "2009-11-30"
    And I press "Search"
    Then I should see "teresa" spend "200" dallors 









