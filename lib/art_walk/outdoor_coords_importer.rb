require 'csv'

module ArtWalk
  class OutdoorCoordsImporter < GenericImporter
    class RowCreator < GenericImporter::RowCreator
      def resource
        if row[1].blank?
          @resource ||= ArtPiece.find_or_initialize_by(:title => "Untitled")
        else
          @resource ||= ArtPiece.find_or_initialize_by(:title => row[1])
        end
      end

      def assign_artist_name(value)
        new_val = value.split(/[;]/)
        new_val.each do |val|
          new_artist = Artist.find_or_create_by(:name => val.strip)
          new_artist.save
          resource.artists << new_artist
        end
        resource.save
      end

      def assign_lat(value)
        resource.lat = value
        resource.save
      end

      def assign_long(value)
        resource.long = value
        resource.save
      end

      def field_mapping
        {
          "LAT" => "lat",
          "LONG" => "long",
          "Artist" => "artists"
        }
      end
    end
  end
end
