# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :art_pieces_artist, :class => 'ArtPiecesArtists' do
    art_pieces nil
    artists nil
  end
end
