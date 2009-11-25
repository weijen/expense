# == Schema Information
#
# Table name: currencies
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Currency do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Currency.create!(@valid_attributes)
  end
end
