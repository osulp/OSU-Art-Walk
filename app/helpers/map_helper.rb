module MapHelper
  include BlacklightMapsHelper
  def serialize_geojson
    export = BlacklightMaps::GeojsonExport.new(controller,@map_results.docs)
    export.to_geojson
  end
end