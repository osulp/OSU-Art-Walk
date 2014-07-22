# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :art_piece_photo, :class => 'ArtPiecePhotos' do
    photo "MyString"
  end
end
