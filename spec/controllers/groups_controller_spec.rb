require 'spec_helper'

include AuthenticatedTestHelper

describe GroupsController do
  before(:each) do
    @user  = mock_user
    login_as(@user)
  end
  context "Get show" do
    before(:each) do
      @group = mock_model(Group)
      Group.should_receive(:find_by_secret_id).and_return(@group)
      @users_report = [["weijen", -200], ["hlb", -300], ["gugod", -400]]
      @group.should_receive(:users_report).and_return(@users_report)
      @tags_report = [["tag1", -22], ["tag2", -300],["tag3", -400]]
      @group.should_receive(:tags_report).and_return(@tags_report)

      get :show
    end

    it "should get group" do
      assigns[:group].should eql(@group)
    end

    it "取得已認證的使用者" do
      assigns[:users_report].should eql(@users_report)
    end

    it "取得在某段時間內，這個group的所以類型的消費" do
      assigns[:tags_report].should eql(@tags_report)
    end
  end

end
