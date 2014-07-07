# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :art_piece_building do
    floor 1
    location "MyString"
    art_piece_id nil
    building_id nil
  end
end
