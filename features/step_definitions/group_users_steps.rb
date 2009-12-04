Given /^a user "([^\"]*)" want join this group$/ do |login|
 @unprove_user = User.create!(
    :login => login,
    :password => 'generic',
    :password_confirmation => 'generic',
    :email => "#{login}@example.com"
  )
 @group.add_unapprove_user(@unprove_user)
 @group.unapprove_users.should include(@unprove_user)
end

Given /^a user "([^\"]*)" is a approved user$/ do |login|
 @proved_user = User.create!(
    :login => login,
    :password => 'generic',
    :password_confirmation => 'generic',
    :email => "#{login}@example.com"
  )
 @group.add_approved_user(@proved_user)
 @group.approved_users.should include(@proved_user)
end

Given /^I follow this group and be approved$/ do
  @group.add_approved_user(@current_user)
end

Given /^I follow this group but still not to be approve$/ do
   @group.add_unapprove_user(@current_user)
end




