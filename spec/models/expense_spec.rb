# == Schema Information
#
# Table name: expenses
#
#  id          :integer         not null, primary key
#  group_id    :integer         not null
#  user_id     :integer         not null
#  tag_id      :integer         not null
#  is_income   :boolean
#  amount      :float           not null
#  note        :string(255)
#  entry_date  :date
#  currency_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Expense do
  before(:each) do
    @valid_attributes = {
      :group_id => 1,
      :user_id => 1,
      :tag_id => 1,
      :is_income => false,
      :amount => 1.5,
      :commit => "value for commit",
      :charge_date => Date.today,
      :currency_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Expense.create!(@valid_attributes)
  end
end
