Feature: 團體的帳目

帳目包含日期時間、團體、幣別、金額、類別、備註

我可以報帳到我所follow的團體

我可以看到我所follow的團體的細帳

我可以看到我所follow的團體的日結、週結、月結（以幣別作分類)

我可以看到我所follow的團體的分類結算

我可以看到我所follow的團體的分類細項

在dashboard可以看到最近20筆，我所follow的團體的其他人的報帳

  Scenario: 我是管理員，我可以報帳到我所follow的團體
    Given I am logged in as "weijen"
    And a group named "test_group" is belongs to me
    When I go to new_expense_path
    And I select "test_group" from "group"
    And I fill in "amount" with "100" 
    And I press "Create"
    Then I should see "Expense was successfully created"

