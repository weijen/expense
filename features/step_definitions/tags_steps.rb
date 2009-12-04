def create_default_tags
  @fake_outgoing_tag_name = %w[差旅費 餐飲費 書報雜誌 影音軟體 雜物 網路服務 吃飯 交通 交際 旅館 書 軟體 飲料 保險費]
  @fake_income_tag_name = %w[會員收費]

  @fake_outgoing_tag_name.each do |name|
    Tag.create!(:name => name, :is_income => false, :user_id => 1)
  end

  @fake_income_tag_name.each do |name|
    Tag.create!(:name => name, :is_income => true, :user_id => 1)
  end
end

Then /^There is a tag named "(.*)" in db$/ do |tag_name|
  @tag = Tag.find_by_name(tag_name)  
  @tag.should_not be_nil
end

Then /^This tag\.user_id is my id$/ do
  @tag.user_id.should eql(@current_user.id)
end

Then /^This tag is outgoing tag$/ do
  @tag.is_income.should be_false 
end

Then /^This tag is income tag$/ do
  @tag.is_income.should be_true
end

Given /^I create a "([^\"]*)" tag named "([^\"]*)"$/ do |kind, tag|
  case kind
  when "income"
    is_income = true
  when "outgoing"
    is_income = false
  else
    raise "tag kind error"
  end
  @tag = Tag.create(:name => tag, :is_income => is_income, :user_id => @current_user.id)
end

Given /^I create a expense belong to this tag$/ do
  @current_user.expenses.create!(:group_id => @group.id, :tag_id => @tag.id, :currency_id => 1, :amount => 100, :note => "Test note", :entry_date => Date.today - 3.day) 
end

