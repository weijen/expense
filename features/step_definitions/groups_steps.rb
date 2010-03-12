Then /^A group named "(.*)" should be created$/ do |group_name|
  @group = Group.find_by_name(group_name) 
  @group.should_not be_nil
end

Then /^I am the manager of this group$/ do
  @group.managers.should include(@current_user) 
end

Given /^a group named "([^\"]*)" is belongs to me$/ do |group_name|
  create_default_tags
  create_default_currencies
  @group = Group.create!(
    :name => group_name,
    :short_name => group_name
  )
  @group.user_group_relations.create(:user_id => @current_user.id, :manager => true, :approved => true)
end

Given /^a group named "([^\"]*)" is not belongs to me$/ do |group_name|
  create_default_tags
  create_default_currencies
  @group = Group.create!(
    :name => group_name,
    :short_name => group_name,
    :tag_ids => Tag.all.map{ |t| t.id }
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

Given /^this group was frozen$/ do
  @group.set_freeze
end

Given /^I am an approved user for this group$/ do
  @group.add_approved_user(@current_user) 
end


