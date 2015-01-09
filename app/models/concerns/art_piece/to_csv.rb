class ArtPiece
  module ToCSV
    extend ActiveSupport::Concern

    included do
      def self.to_csv
        CSV.generate do |csv|
          csv << ["Art Piece Name", "Created on", "Size", "Legal Info", "Contact Info", "Description", 
                  "Displayed", "Private", "Number", "Artist Comments", "Art Piece Latitude", 
                  "Art Piece Longitude", "Photo Credit", "Artist Name", "Artist Bio", "Artist Birthdate",
                  "Artist Deathdate", "Artist Is Student", "Artist Is Faculty", "Artist Is Featured", "Building Name", 
                  "Building Description", "Building Latitude", "Building Longitude", "Floor", 
                  "Location in Building", "Position in Building", "Collections", "Media", "Series", 'Art Piece Photo Credit']
          all.each do |art|
            csv << [art.title, art.creation_date, art.size, art.legal_info, art.contact_info, 
                    art.description, art.displayed, art.private, art.number, art.artist_comments,
                    art.lat, art.long, art.global_photo_credit, art.artists.map{|artist| artist.name}.compact.join("; "), 
                    art.artists.map{|artist| artist.bio}.compact.join(", "), art.artists.map{|artist| artist.birthdate}.compact.join(", "),
                    art.artists.map{|artist| artist.deathdate}.compact.join(", "), art.artists.map{|artist| artist.student}.compact.join(", "),
                    art.artists.map{|artist| artist.faculty}.compact.join(", "), art.artists.map{|artist| artist.featured}.compact.join(", "),
                    art.building_name, art.building_description, art.building_lat, art.building_long,
                    art.art_piece_building_floor, art.art_piece_building_location, art.art_piece_building_position_num, 
                    art.collections.map{|collection| collection.name}.compact.join(", "), art.media.map{|media| media.medium}.compact.join(", "),
                    art.series.map{|series| series.name}.compact.join(", "), art.art_piece_photos.map{|photo| photo.photo_credit}.compact.join(", ")]
          end
        end
      end
    end
  end
end