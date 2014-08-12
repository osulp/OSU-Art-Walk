module MapHelper
  include BlacklightMapsHelper
  def serialize_geojson
    export = BlacklightMaps::GeojsonExport.new(controller,@map_results)
    export.to_geojson
  end
  
  def map_counter(document)
    return nil if !@map_results || @map_results.length == 1
    map_counter = @map_results.index{|d| d["id"] == document.id}
    map_counter += 1 if map_counter
    return map_counter
  end
end
