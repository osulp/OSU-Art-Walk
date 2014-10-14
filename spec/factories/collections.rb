# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collection do
    sequence(:name) { |n| "Collection#{n}" }
    collection_url nil
  end
end
