Given /^There are 10 users joined to "([^\"]*)"$/ do |group|
  group = Group.find_by_name(group)
  %w[teresa tiffany tina tracy ursula vanessa vicky vivian wendy yvette].each do |name|
    user = User.create!(
      :login => name,
      :password => 'expense2009',
      :password_confirmation => 'expense2009',
      :email => "#{name}@example.com"
    )
    group.add_approved_user(user)
  end
  group.users.length.should eql(11)
end

Given /^There are 100 expenses belongs to "([^\"]*)"$/ do |group|
  group = Group.find_by_name(group)
  %w[teresa tiffany tina tracy ursula vanessa vicky vivian wendy yvette].each do |name|
    user = User.find_by_login(name)
    date = Date.parse("2009-12-10")
    (0..9).each do |i|
      entry_date = date - i.month
      user.expenses.create!(:group_id => group.id, :tag_id => 1, :currency_id => 1, :entry_date => entry_date, :amount => (i + 1) * 100, :note => entry_date.to_s(:db))
    end
  end
  group.expenses.length.should eql(100)
end

Then /^I should see "([^\"]*)" spend "([^\"]*)" dallors$/ do |name, amount|
  save_and_open_page
  user = User.find_by_login(name)
  within("tr#user_report_" + user.login) do |tr|
    tr.should contain(name)
    tr.should contain(amount)
  end
end


