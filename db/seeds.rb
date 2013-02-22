# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :first_name => 'Mitch', :last_name => 'Nick', :email => 'user@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => DateTime.now
user2 = User.create! :first_name => 'Steve', :last_name => 'Smith', :email => 'user2@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => DateTime.now
puts 'New user created: ' << user.first_name
adminuser = AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')