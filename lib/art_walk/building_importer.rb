require 'csv'

module ArtWalk
  class BuildingImporter < GenericImporter
    class RowCreator < GenericImporter::RowCreator
      def model
        Building
      end

      def resource
        @resource ||= model.find_or_initialize_by(:name => row[0])
      end

      def field_mapping
        {
          "lat" => "lat",
          "long" => "long"
        }
      end
    end
  end
end
