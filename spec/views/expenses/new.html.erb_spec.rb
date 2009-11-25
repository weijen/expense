require 'spec_helper'

describe "/expenses/new.html.erb" do
  include ExpensesHelper

  before(:each) do
    assigns[:expense] = stub_model(Expense,
      :new_record? => true,
      :group_id => 1,
      :user_id => 1,
      :tag_id => 1,
      :is_income => false,
      :amount => 1.5,
      :commit => "value for commit",
      :currency_id => 1
    )
  end

  it "renders new expense form" do
    render

    response.should have_tag("form[action=?][method=post]", expenses_path) do
      with_tag("input#expense_group_id[name=?]", "expense[group_id]")
      with_tag("input#expense_user_id[name=?]", "expense[user_id]")
      with_tag("input#expense_tag_id[name=?]", "expense[tag_id]")
      with_tag("input#expense_is_income[name=?]", "expense[is_income]")
      with_tag("input#expense_amount[name=?]", "expense[amount]")
      with_tag("input#expense_commit[name=?]", "expense[commit]")
      with_tag("input#expense_currency_id[name=?]", "expense[currency_id]")
    end
  end
end
