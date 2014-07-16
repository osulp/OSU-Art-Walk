# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting, :class => 'Setting' do
    copyright "MyText"
    email "MyString"
    about "MyText"
  end
end
