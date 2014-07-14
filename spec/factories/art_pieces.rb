# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :art_piece, :class => 'ArtPiece' do
    sequence(:title) { |n| "Art Piece #{n}" }
    medium "MyString"
    creation_date "2014-07-02 13:58:43"
    size "MyString"
    legal_info "MyText"
    temporary false
    temporary_until "2014-07-02 13:58:43"
    private false
    contact_info "MyString"
    description "MyText"
    on_campus false

    trait :with_building do
      after(:build) do |art_piece|
        art_piece.building = build(:building)
      end
    end

    trait :with_artist do
      after(:build) do |art_piece|
        art_piece.artists = [build(:artist)]
      end
    end
  end
end
