require 'spec_helper'

describe UserGroupRelation do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :group_id => 1,
      :approved => false,
      :manager => false
    }
  end

  it "should create a new instance given valid attributes" do
    UserGroupRelation.create!(@valid_attributes)
  end
end

# == Schema Information
#
# Table name: user_group_relations
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  group_id   :integer         not null
#  approved   :boolean         default(FALSE)
#  manager    :boolean         default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

