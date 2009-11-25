Given /^a user "([^\"]*)" want follow this group$/ do |login|
 @unprove_user = User.create!(
    :login => login,
    :password => 'generic',
    :password_confirmation => 'generic',
    :email => "#{login}@example.com"
  )
 @group.add_unprove_user(@unprove_user)
 @group.unprove_users.should include(@unprove_user)
end

Given /^a user "([^\"]*)" is the proven follower$/ do |login|
 @proved_user = User.create!(
    :login => login,
    :password => 'generic',
    :password_confirmation => 'generic',
    :email => "#{login}@example.com"
  )
 @group.add_follower(@proved_user)
 @group.followers.should include(@proved_user)
end


