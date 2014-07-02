# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :art_piece, :class => 'ArtPieces' do
    sequence(:title) {|n| "Art Piece #{n}"}
    medium "MyString"
    creation_date "2014-07-02 13:58:43"
    size "MyString"
    legal_info "MyText"
    is_temporary false
    temporary_until "2014-07-02 13:58:43"
    private false
    contact_info "MyString"
    description "MyText"
    on_campus false
  end
end
