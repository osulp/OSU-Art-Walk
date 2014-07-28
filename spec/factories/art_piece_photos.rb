# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :art_piece_photo, :class => 'ArtPiecePhoto' do
    trait :with_photo do
      photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'cats.jpg')) }
    end
  end
end
