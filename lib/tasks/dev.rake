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

  task :fake => :environment do
  end
end
