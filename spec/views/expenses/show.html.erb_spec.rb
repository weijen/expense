require 'spec_helper'

describe "/expenses/show.html.erb" do
  include ExpensesHelper
  before(:each) do
    assigns[:expense] = @expense = stub_model(Expense,
      :group_id => 1,
      :user_id => 1,
      :tag_id => 1,
      :is_income => false,
      :amount => 1.5,
      :commit => "value for commit",
      :currency_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/false/)
    response.should have_text(/1\.5/)
    response.should have_text(/value\ for\ commit/)
    response.should have_text(/1/)
  end
end
