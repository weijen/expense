# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  name       :string(255)     not null
#  is_income  :boolean
#  counter    :integer         default(0)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Tag do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :name => "value for name",
      :is_income => false
    }
  end

  it "should create a new instance given valid attributes" do
    Tag.create!(@valid_attributes)
  end
end
