require 'spec_helper'

describe Expense do
  before(:each) do
    @tag = Tag.create!(:name => "test tag", :user_id => 1, :is_income => false)
    @group = Group.create!(:name => "test group", :short_name => "tgg")
    @valid_attributes = {
      :group_id => @group.id,
      :user_id => 1,
      :tag_id => @tag.id,
      :amount => 1.5,
      :note => "value for note",
      :entry_date => Date.today,
      :currency_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Expense.create!(@valid_attributes)
  end
end

# == Schema Information
#
# Table name: expenses
#
#  id          :integer         not null, primary key
#  group_id    :integer         not null
#  user_id     :integer         not null
#  tag_id      :integer         not null
#  is_income   :boolean         default(FALSE)
#  amount      :float           not null
#  note        :string(255)
#  entry_date  :date
#  currency_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

