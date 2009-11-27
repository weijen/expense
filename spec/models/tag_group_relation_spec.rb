require 'spec_helper'

describe TagGroupRelation do
  before(:each) do
    @valid_attributes = {
      :tag_id => 1,
      :group_id => 1,
      :counter => 1
    }
  end

  it "should create a new instance given valid attributes" do
    TagGroupRelation.create!(@valid_attributes)
  end
end
