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
  click_button
  response.body.should =~ /successfully/m  
end


Then /^I join this group but not approve$/ do
  @current_user.reload
  @current_user.groups.should include(@group)
end

Then /^I should not see "([^\"]*)" button$/ do |value|
  response.should_not have_selector("input[type=submit]", :value => value)
end

