require 'csv'

module ArtWalk
  class ArtistImporter < GenericImporter

    class RowCreator< GenericImporter::RowCreator

      def model
        Artist
      end

      def assign_artist_name(value)
        @resource = model.find_or_initialize_by(:name => value)
        @resource.save
      end

      def field_mapping
        {
          "born" => "birthdate",
          "died" => "deathdate",
          "artist_website" => "website",
          "bio" => "bio",
          "osu_faculty_past_or_present" => "faculty",
          "osu_student_past_or_present" => "student"
        }
      end
    end
  end

end
