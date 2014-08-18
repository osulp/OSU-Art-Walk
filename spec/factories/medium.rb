# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :medium do
    sequence(:medium) { |n| "Medium#{n}" }
  end
end
