require 'spec_helper'

describe "/expenses/index.html.erb" do
  include ExpensesHelper

  before(:each) do
    assigns[:expenses] = [
      stub_model(Expense,
        :group_id => 1,
        :user_id => 1,
        :tag_id => 1,
        :is_income => false,
        :amount => 1.5,
        :commit => "value for commit",
        :currency_id => 1
      ),
      stub_model(Expense,
        :group_id => 1,
        :user_id => 1,
        :tag_id => 1,
        :is_income => false,
        :amount => 1.5,
        :commit => "value for commit",
        :currency_id => 1
      )
    ]
  end

  it "renders a list of expenses" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", "value for commit".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
