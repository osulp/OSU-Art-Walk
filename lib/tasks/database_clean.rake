namespace :artwalk do
  desc "Removes entries from database"
  task :clean => :environment do
    model_array = [ArtPiece, Artist, Medium, Series, Collection, Building, ArtPiecePhoto, 
                  ArtPieceArtist, ArtPieceCollection, ArtPieceMedium, ArtPieceSeries]
    model_array.each {|model| model.destroy_all}
  end
end
