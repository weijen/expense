Given /^I am logged in as "(.*)"$/ do |login|
  @current_user = User.create!(
    :login => login,
    :password => 'generic',
    :password_confirmation => 'generic',
    :email => "#{login}@example.com"
  )

  # :create syntax for restful_authentication w/ aasm. Tweak as needed.
  # @current_user.activate! 

  visit "/login" 
  fill_in("login", :with => login) 
  fill_in("password", :with => 'generic') 
  click_button("Log in")
  response.body.should =~ /Logged/m  
end

Then /^A group named "(.*)" should be created$/ do |group_name|
  @group = Group.find_by_name(group_name) 
  @group.should_not be_nil
end

Then /^I am the manager of this group$/ do
  @group.owner.should eql(@current_user) 
end

Given /^a group named "([^\"]*)" is belongs to me$/ do |group_name|
  @group = Group.create!(
    :name => group_name,
    :short_name => group_name,
    :owner_id => @current_user.id
  )
end

Given /^a group named "([^\"]*)" is not belongs to me$/ do |group_name|
  @group = Group.create!(
    :name => group_name,
    :short_name => group_name
  )
end

Then /^the group name become "([^\"]*)"$/ do |group_name|
  @group = @group.reload
  @group.name.should eql(group_name)
end

Then /^the group is not exist$/ do
  @group = @group.reload
  @group.should be_nil
end



