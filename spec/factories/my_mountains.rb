require 'faker'

FactoryGirl.define do
  factory :my_mountain do
  	mountain {|a| a.association(:mountain)}
  	user {|a| a.association(:user)}
  	type MyMountainRole::HAVEBEEN
  end
end