require 'faker'

FactoryGirl.define do
	factory :region do
    name {Faker::Name::name}
  end
  factory :mountain do
    name {Faker::Name::name}
    region {|a| a.association(:region)}
    description {Faker::Lorem.paragraph(3)}
  end
end