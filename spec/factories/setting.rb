# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting, :class => 'Setting' do
    setting_name "MyString"
    value "MyText"
  end
end
