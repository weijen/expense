require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Welcome/index.html.erb" do
  before(:each) do
    @groups = (1..2).to_a.map{ |i| mock_model(Group, :name => "test group #{i}", :short_name => "tg#{i}") }
    @current_user = mock_model(User,
                               :login => "weijen",
                               :password => 'generic',
                               :password_confirmation => 'generic',
                               :email => "weijen@example.com",
                               :groups => @groups
                              )
    assigns[:current_user] = @current_user
  end

  it "should have 10 columns for groups short name" do
    render "welcome/index.html.erb"
    response.capture(:sidebar).should have_tag("div", :id=>'sidebar') do |div|
      div.should have_tag("h2") do |h2|
        h2.should contain("Groups I followed")
      end
      div.should have_tag("table") do |table|
        table.should contain("tg1")
        table.should contain("tg2")
      end 
    end
  end
end
