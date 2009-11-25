require 'spec_helper'

describe Tag do
  before(:each) do
    @valid_attributes = {
      :group_id => 1,
      :user_id => 1,
      :name => "value for name",
      :is_income => false
    }
  end

  it "should create a new instance given valid attributes" do
    Tag.create!(@valid_attributes)
  end
end
