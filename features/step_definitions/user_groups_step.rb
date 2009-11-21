Given /^a user is logged in as "(.*)"$/ do |login|
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

When /^I visit groups\/new$/ do
  pending
end

When /^I inpus group's name and short name$/ do
  pending
end

When /^I sumbit$/ do
  pending
end

Then /^show group's profile$/ do
  pending
end

Then /^I'm the manager of this group$/ do
  pending
end

