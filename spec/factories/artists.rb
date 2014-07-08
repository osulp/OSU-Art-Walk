# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist do
    sequence(:name) { |n| "picasso#{n}" }
    bio "MyText"
    website "MyString"
    birthdate "MyString"
    deathdate "MyString"
  end
end
