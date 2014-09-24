namespace :artwalk do
  desc "Removes entries from database"
  task :clean => :environment do
    ModelArray = [ArtPiece, Artist, Medium, Series, Collection, Building, ArtPiecePhoto, 
                  ArtPieceArtist, ArtPieceCollection, ArtPieceMedium, ArtPieceSeries]
    ModelArray.each {|model| model.destroy_all}
  end
end
