require 'spec_helper'

describe UserGroupRelation do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :group_id => 1,
      :proven => false
    }
  end

  it "should create a new instance given valid attributes" do
    UserGroupRelation.create!(@valid_attributes)
  end
end
