# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :building do
    sequence(:name) { |n| "ValleyLib#{n}" }
    description "MyText"
    lat {rand(-64.0..64.0)}
    long {rand(-64.0..64.0)}
  end
end
