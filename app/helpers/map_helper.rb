module MapHelper
  include BlacklightMapsHelper
  include Blacklight::UrlHelperBehavior
  def serialize_geojson
    export = BlacklightMaps::GeojsonExport.new(controller, map_results.reverse)
    export.to_geojson
  end
  
  def map_results
    @map_results || @document_list
  end

  def map_counter(document)
    return nil if !@map_results || @map_results.length == 1
    return building_counter(document) if cleaned_params.blank?
    map_counter = @map_results.index{|d| d["id"] == document.id}
    map_counter += 1 if map_counter
    return map_counter
  end

  def building_counter(document)
    map_counter = @map_results.select{|d| d["building_ss"] == document["building_ss"]}.index{|d| d["id"] == document.id}
    map_counter += 1 if map_counter
    map_counter
  end

  def link_to_map_document(doc, opts={:label => nil, :counter => nil})
    opts[:label] ||= document_show_link_field(doc)
    label = render_document_index_label doc, opts
    search_context = opts[:search_context].to_json if opts[:search_context].present?
    link_to label, catalog_path(doc, :search_context => search_context), document_link_params(doc, opts)
  end

  def map_building(document)
    return nil unless params[:action] == "index" && cleaned_params.blank?
    {:f => {:building_ss => document["building_ss"]}, :sort => "art_piece_building_position_num_is asc"}
  end


end
