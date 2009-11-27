require File.dirname(__FILE__) + "/dev_data.rb"

namespace :dev do

  desc "Rebuild system"
  task :build => ["tmp:clear","db:drop", "db:create", "db:migrate", :setup]

  task :setup => :environment do
    puts "Create users"
    User.create!(
      :login => "root",
      :password => 'expense2009',
      :password_confirmation => 'expense2009',
      :email => "service@example.com"
    )

    puts "Create Currencies"
    Currency.create!(:name => "TWD")
  end

  desc "Build fake data"
  task :fake => :environment do
    puts "Create Users"
    (@fake_english_name_man + @fake_english_name_woman).each do |name|
      User.create!(:login => name, :password => 'expense2009', :password_confirmation => 'expense2009', :email => "#{name}@example.com")
    end

    users = User.find :all
    range = 20

    puts "Create Tags"
    @fake_outgoing_tag_name.each do |name|
      Tag.create!(:user_id => users[rand(range)].id, :name => name, :is_income => false)
    end

    @fake_income_tag_name.each do |name|
      Tag.create!(:user_id => users[rand(range)].id, :name => name, :is_income => true)
    end


    puts "Create Group"
        @fake_group_name.each_with_index do |name, i|
      group = Group.create!(:name => name, :short_name => name)
      group.add_manager(users[i])
      group.tags << Tag.find(:all)

      puts "Setting followers and create expenses"
      followed_users_position = []
      10.times do
        user_position = rand(range + 9)
        redo if followed_users_position.include?(user_position)
        followed_users_position << user_position
        user = users[user_position]
        group.add_approved_user(user)

        5.times do
          entry_date = Date.today - rand(10).days
          amount = (rand(20) + 1) * 100
          tag = Tag.find(rand(11) + 1)
          Expense.create!(:group_id => group.id, :user_id => user.id, :tag_id => tag.id, :amount => amount, :comment => "Testing expense", :entry_date => entry_date, :currency_id => 1 )
        end
      end

      10.times do
        user_position = rand(range + 9)
        redo if followed_users_position.include?(user_position)
        followed_users_position << user_position
        group.add_unapprove_user(users[user_position])
      end
    end #create groups
  end
end
