# == Schema Information
#
# Table name: groups
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  short_name :string(255)
#  secret_id  :string(255)
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Group do
  before(:each) do
    @valid_attributes = {
      :name => "test_group",
      :short_name => "tg"
    }
  end

  it "should create a new instance given valid attributes" do
    Group.create!(@valid_attributes)
  end

  context "與User間的關係" do 
    before(:each) do
      @group = Group.create!(@valid_attributes)
      @p_user = User.create!(
        :login => "proven_user",
        :password => 'generic',
        :password_confirmation => 'generic',
        :email => "proven_user@example.com"
      )
      @up_user = User.create!(
        :login => "unproven_user",
        :password => 'generic',
        :password_confirmation => 'generic',
        :email => "unproven_user@example.com"
      )

      @group.users << @p_user
      @group.users << @up_user
      @group.add_follower(@p_user)
    end
    it "should have 2 user_group_relations" do
      @group.user_group_relations.length.should eql(2)
    end

    it "should have 2 users" do
      group = Group.find_by_name("test_group")
      group.users.length.should eql(2)
    end
    it "should get a proven users in this group" do
      @group.users.proven.length.should eql(1)
      @group.users.proven[0].should eql(@p_user)
    end

    it "should get an unproven users in this group"  do
      @group.users.unproven.length.should eql(1)
      @group.users.unproven[0].should eql(@up_user)
    end

    it "should get ture when user be added to managers" do
      user =  User.create!(
        :login => "test",
        :password => 'generic',
        :password_confirmation => 'generic',
        :email => "test@example.com"
      )
      @group.add_manager(user)
      @group.owners.should include(user)
    end
  end
end
