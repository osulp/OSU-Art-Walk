# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :building do
    name "MyString"
    description "MyText"
    lat 1.5
    long 1.5
  end
end
