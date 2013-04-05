include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    email 'example@example.com'
    password 'password1'
    password_confirmation 'password1'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end
  factory :region do
    name 'Rockies'
  end
  factory :mountain do
    name 'Breck Test'
    region {|a| a.association(:region)}
    description 'This is my testing mountain only'
  end
  factory :my_mountain do
  	mountain {|a| a.association(:mountain)}
  	user {|a| a.association(:user)}
  	type MyMountainRole::HAVEBEEN
  end
  factory :photo do 
    name 'My Photo Test'
    description 'My lovely description'
    mountain {|a| a.association(:mountain)}
    image { fixture_file_upload(Rails.root + 'spec/fixtures/files/breck.jpg', "image/jpeg")}
  end
end