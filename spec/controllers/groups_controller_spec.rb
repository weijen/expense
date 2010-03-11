require 'spec_helper'

include AuthenticatedTestHelper

describe GroupsController, "test route" do
  it "should route for show" do
    route_for(:controller => "groups", :action => "show", :id => "abcde").should == "groups/abcde"
  end
end

describe GroupsController, "Get show" do
  before(:each) do
    @user  = mock_user
    login_as(@user)

    @group = mock_model(Group, :secret_id => "abcde", :created_at => "2010-01-01 00:00:00")

    Group.should_receive(:find_by_secret_id).and_return(@group)
    @users_report = [["weijen", -200], ["hlb", -300], ["gugod", -400]]
    @group.should_receive(:users_report).and_return(@users_report)
    @tags_report = [["tag1", -22], ["tag2", -300],["tag3", -400]]
    @group.should_receive(:tags_report).and_return(@tags_report)
    get :show, :id => "abcde"
    response.inspect
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

describe GroupsController, "freeze group" do
  before(:each) do
    @user  = mock_user
    login_as(@user)

    User.stub!(:find_by_id).with(@user.id).and_return(@user)

    @group = mock_model(Group, :secret_id => "abcde", :created_at => "2010-01-01 00:00:00")

    Group.should_receive(:find_by_secret_id).and_return(@group)
  end

  it "應該回到'/'，如果使用者不是管理員" do
    @user.should_receive(:manager?).and_return(false)
    post :freeze, :id => "abcde"
    response.should redirect_to("/")

    stickies_messages = Array.new
    response.session["stickies"].each { |m| stickies_messages << m.message }
    stickies_messages.should include("You have no right to access this page")
  end

  it "應該回到show，如果使用者是管理員，而且告知此團體已經凍結" do
    @user.should_receive(:manager?).and_return(true)
    @group.should_receive(:set_freeze)
    post :freeze, :id => "abcde"
    response.should redirect_to(group_path(@group))

    stickies_messages = Array.new
    response.session["stickies"].each { |m| stickies_messages << m.message }
    stickies_messages.should include("This group was frozen")
  end
end

describe GroupsController, "alive group" do
  before(:each) do
    @user  = mock_user
    login_as(@user)

    User.stub!(:find_by_id).with(@user.id).and_return(@user)

    @group = mock_model(Group, :secret_id => "abcde", :created_at => "2010-01-01 00:00:00")

    Group.should_receive(:find_by_secret_id).and_return(@group)
  end

  it "應該回到'/'，如果使用者不是管理員" do
    @user.should_receive(:manager?).and_return(false)
    post :alive, :id => "abcde"
    response.should redirect_to("/")

    stickies_messages = Array.new
    response.session["stickies"].each { |m| stickies_messages << m.message }
    stickies_messages.should include("You have no right to access this page")
  end

  it "應該回到show，如果使用者是管理員，而且告知此團體已經凍結" do
    @user.should_receive(:manager?).and_return(true)
    @group.should_receive(:set_alive)
    post :alive, :id => "abcde"
    response.should redirect_to(group_path(@group))
  end
end
