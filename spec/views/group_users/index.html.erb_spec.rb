require 'spec_helper'

describe "/group_users/index" do
  before(:each) do
    @group = mock_model(Group, :name => "test group", :short_name => "tg")
    users = (1..10).map do |i|
      user = mock_model(User,
                        :login => "user#{i}",
                        :password => 'generic',
                        :password_confirmation => 'generic',
                        :email => "user#{i}@example.com",
                        :groups => @group) 
      case
      when i <= 3
        ans = "manager"
        @group.should_receive(:followers).and_return([])
        @group.should_receive(:unprove_users).and_return([])
      when i > 3 && i <= 6
        ans = "follower"
        @group.should_receive(:followers).and_return([user])
        @group.should_receive(:unprove_users).and_return([])
      when i > 6
        ans = "unproven"
        @group.should_receive(:followers).and_return([])
        @group.should_receive(:unprove_users).and_return([user])
      end
      
      user.should_receive(:position).with(@group).and_return(ans)
      user
    end

    
    assigns[:followers] = users
    assigns[:group] = @group

    render 'group_users/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('h1', "All Followers")
  end

  it "should have a table to show all followers" do
    response.should have_selector("table") do |table|
      table.should have_selector("thead") do |thead|
        thead.should have_selector("tr") do |tr|
          tr.should have_selector("th") do |th| 
            th.should contain("login")
          end
          tr.should have_selector("th") do |th| 
            th.should contain("relation")
          end
        end
      end

      table.should have_selector("tbody") do |tbody|
        (1..10).each do |i|
          tbody.should have_selector("tr") do |tr|
            tr.should have_selector("td") do |td|
              td.should contain("user#{i}")
            end
            #tr.should have_selector("td") do |td|
              #td.should contain(/manager/) if i <= 3
              #td.should contain(/follower/) if i > 3 && i <= 6
              #td.should contain(/unproven/) if i > 6
            #end
          end #tr
        end #each
      end #tbody
    end #table
  end
end
