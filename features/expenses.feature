Feature: 團體的帳目

帳目包含日期時間、團體、幣別、金額、類別、備註

(done)我可以報帳到我所follow的團體

我可以看到我所follow的團體的細帳

我可以看到我所follow的團體的日結、週結、月結（以幣別作分類)

我可以看到我所follow的團體的分類結算

我可以看到我所follow的團體的分類細項

在dashboard可以看到最近20筆，我所follow的團體的其他人的報帳

  Scenario: 我是管理員，我可以新增收入到我所follow的團體
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    When I go to new_income_path
    And I select "test_group" from "group"
    And I select "會員收費" from "tag"
    And I fill in "amount" with "100" 
    And I press "Create"
    Then I should see "Expense was successfully created"

  Scenario: 我是approved user，我可以新增收入到我所follow的團體
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    And I follow this group and be approved
    When I go to new_income_path
    And I select "test_group" from "group"
    And I select "會員收費" from "tag"
    And I fill in "amount" with "100" 
    And I press "Create"
    Then I should see "Expense was successfully created"

  Scenario: 我是unapprove user，我無法選到我已經參與，但是還沒被approve的團體，在新增收入的時候
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    And I follow this group but still not to be approve
    When I go to new_income_path
    Then the "group" field should not contain "test_group"

   Scenario: 我無法選到我沒有參與的團體，在新增收入的時候
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    When I go to new_income_path
    Then the "group" field should not contain "test_group"

   Scenario: 我是管理員，我可以新增支出到我所follow的團體
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    When I go to new_outgoing_path
    And I select "test_group" from "group"
    And I select "差旅費" from "tag"
    And I fill in "amount" with "100" 
    And I press "Create"
    Then I should see "Expense was successfully created"

  Scenario: 我是approved user，我可以新增支出到我所follow的團體
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    And I follow this group and be approved
    When I go to new_outgoing_path
    And I select "test_group" from "group"
    And I select "差旅費" from "tag"
    And I fill in "amount" with "100" 
    And I press "Create"
    Then I should see "Expense was successfully created"

  Scenario: 我是unapprove user，我無法選到我已經參與，但是還沒被approve的團體，在新增支出的時候
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    And I follow this group but still not to be approve
    When I go to new_outgoing_path
    Then the "group" field should not contain "test_group"

   Scenario: 我無法選到我沒有參與的團體，在新增支出的時候
    Given I am logged in as "weijen"
    And a group named "test_group" is not belongs to me
    When I go to new_outgoing_path
    Then the "group" field should not contain "test_group"

#---------------------- Scenraio Outline--------------------------------
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

  @here
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











