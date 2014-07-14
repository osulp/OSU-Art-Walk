# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :art_piece_collection, :class => 'ArtPieceCollections' do
    art_piece nil
    collection nil
  end
end
