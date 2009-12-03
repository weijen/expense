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
      :short_name => "tgg"
    }
  end

  it "should create a new instance given valid attributes" do
    Group.create!(@valid_attributes)
  end

  context "與User間的關係" do 
    before(:each) do
      @group = Group.create!(@valid_attributes)
      @p_user = User.create!(
        :login => "approved_user",
        :password => 'generic',
        :password_confirmation => 'generic',
        :email => "approved_user@example.com"
      )
      @up_user = User.create!(
        :login => "unapprove_user",
        :password => 'generic',
        :password_confirmation => 'generic',
        :email => "unapprove_user@example.com"
      )

      @group.users << @p_user
      @group.users << @up_user
      @group.add_approved_user(@p_user)
    end
    it "should have 2 user_group_relations" do
      @group.user_group_relations.length.should eql(2)
    end

    it "should have 2 users" do
      group = Group.find_by_name("test_group")
      group.users.length.should eql(2)
    end
    it "should get a proven users in this group" do
      @group.users.approved_users.length.should eql(1)
      @group.users.approved_users.should include(@p_user)
    end

    it "should get an unproven users in this group"  do
      @group.users.unapprove_users.length.should eql(1)
      @group.users.unapprove_users.should include(@up_user)
    end

    it "should get ture when user be added to managers" do
      user =  User.create!(
        :login => "test",
        :password => 'generic',
        :password_confirmation => 'generic',
        :email => "test@example.com"
      )
      @group.add_manager(user)
      @group.managers.should include(user)
    end

    it "should get true when user request to join this group" do
      user =  User.create!(
        :login => "test",
        :password => 'generic',
        :password_confirmation => 'generic',
        :email => "test@example.com"
      )
      @group.add_unapprove_user(user)
      @group.unapprove_users.should include(user)
    end
  end
end
