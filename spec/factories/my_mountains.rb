require 'faker'

FactoryGirl.define do
  factory :my_mountain do
  	mountain {|a| a.association(:mountain)}
  	user {|a| a.association(:user)}
  	
  	trait :been_here do
  		type MyMountainRole::HAVEBEEN
  	end
  	trait :want_to_go do
  		type MyMountainRole::WANTTOGO
  	end
  end
end