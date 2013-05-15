require 'faker'
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do |user|
    user.name {Faker::Name::name}
    user.email {Faker::Internet::email}
    user.password 'password1'
    user.password_confirmation 'password1'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now

    trait :user_image do
    	photo { fixture_file_upload(Rails.root + 'spec/fixtures/files/breck.jpg', "image/jpeg")}
  	end
  end
end