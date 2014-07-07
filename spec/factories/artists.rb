# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist do
    name "MyString"
    bio "MyText"
    website "MyString"
    birthdate "MyString"
    deathdate "MyString"
  end
end
