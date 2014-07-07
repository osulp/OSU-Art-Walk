# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "User#{n}@example.com"}
    password "password"
    password_confirmation "password"

    trait :admin do
      admin true
    end
  end
end
