module MapHelper
  include BlacklightMapsHelper
  def serialize_geojson
    export = BlacklightMaps::GeojsonExport.new(controller,@map_results)
    export.to_geojson
  end
  
  def map_counter(document)
    return nil if @response.docs.length == 1
    map_counter = @response.docs.index(document.to_hash)
    map_counter += 1 if map_counter
    return map_counter
  end
end
