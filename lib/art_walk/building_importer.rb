require 'csv'

module ArtWalk
  class BuildingImporter < GenericImporter
    class RowCreator < GenericImporter::RowCreator
      def model
        Building
      end

      def assign_building_name(value)
        @resource = Building.find_or_initialize_by(:name => value.strip)
        @resource.save
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
