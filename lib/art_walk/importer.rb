require 'csv'

module ArtWalk
  class Importer < GenericImporter
    class RowCreator < GenericImporter::RowCreator
      def assign_artist_name(value)
        new_val = value.split(/[&;]/)
        new_val.each do |val|
          new_artist = Artist.find_or_initialize_by(:name => val.strip)
          new_artist.save
          resource.artists = [new_artist]
        end
        resource.save
      end

      def assign_building(value)
        new_building = Building.find_or_initialize_by(:name => value.strip)
        new_building.save
        resource.building = new_building
        resource.save
      end

      def assign_collection(value)
        if value != nil
          new_collection = Collection.find_or_initialize_by(:name => value.strip)
          new_collection.save
          resource.collections << new_collection
          resource.save
        end
      end

      def assign_series(value)
        new_val = value.to_s.split(/[,]/)
        resource.series = []
        new_val.each do |val|
          new_series = Series.find_or_initialize_by(:name => val.strip)
          resource.series << new_series
        end
        resource.save
      end

      def assign_medium(value)
        new_val = value.to_s.gsub(" and ", ",").split(/[;,]/).delete_if(&:blank?)
        resource.media = []
        new_val.each do |val|
          new_media = Medium.find_or_initialize_by(:medium => val.strip)
          resource.media << new_media
        end
        resource.save
      end

      def assign_accessibility(value)
        if value == "Public"
          resource.private = false
        else
          resource.private = true
        end
        resource.contact_info = value
        resource.save
      end

      def assign_lost_moving_to_be_hidden(value)
        if value == "FALSE"
          resource.displayed = true
        else
          resource.displayed = false
        end
        resource.save
      end

      def assign_location(value)
        resource.art_piece_building.location = value
        resource.save
      end

      def assign_number_for_website(value)
        resource.art_piece_building.position_num = value
        resource.save
      end

      def assign_work_title(value)
        if value.blank?
          resource.title = "untitled"
        else
          resource.title = value
        end
        resource.save
      end

      def field_mapping
        {
          "additional_information_including_all_data_collected_from_plaques_that_accompany_the_pieces" => "description",
          "year" => "creation_date",
          "dimensions" => "size",
          "artist_notes" => "artist_comments",
          "lost_moving_to_be_hidden" => "displayed",
          "number_on_plaque_valley_nw_art_exhibit_only" => "number"
        }
      end

    end
  end
end
