require 'faker'

FactoryGirl.define do
  factory :gnar do 
  	user {|a| a.association(:user)}
  	photo {|a| a.association(:photo)}
  end
end