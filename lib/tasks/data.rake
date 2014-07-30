
namespace :data do
  desc "Imports CSV Data"
  task :import  => :environment do
    file = File.open("config/building.csv")
    CSV.foreach(file.path, :headers => true) do |row|
      Building.create! row.to_hash
    end
    file = File.open("config/artists.csv")
    CSV.foreach(file.path, :headers => true) do |row|
      Artist.create! row.to_hash
    end
    file = File.open("config/art_piece.csv")
    CSV.foreach(file.path, :headers => true) do |row|
      ArtPiece.create! row.to_hash
    end
  end
end