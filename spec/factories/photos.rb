require 'faker'
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :photo do 
    name {Faker::Name::name}
    description {Faker::Lorem.paragraph(3)}
    mountain {|a| a.association(:mountain)}
    image { fixture_file_upload(Rails.root + 'spec/fixtures/files/breck.jpg', "image/jpeg")}
  end
end