# -*- encoding : utf-8 -*-
#

class CatalogController < ApplicationController  

  include Blacklight::Catalog

  #filter out not-diplayed art pieces
  self.solr_search_params_logic += [:exclude_not_displayed_items]
  self.solr_search_params_logic += [:exclude_displayed_facet]

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => "search",
      :rows => 10
    }
    ## Default values
    config.view.maps.type = "placename_coord" # also accepts 'placename_coord'/'bbox' to use the placename coordinate type
    config.view.maps.bbox_field = "place_bbox"
    config.view.maps.placename_coord_field = "coords_sms"
    config.view.maps.tileurl = "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
    config.view.maps.attribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
    config.view.maps.placename_coord_delimiter = '-|-'
    config.view.maps.minzoom = 16
    config.view.maps.maxzoom = 17

    config.view.maps.default = true

    config.index.title_field = "title_ss"
    config.index.thumbnail_field = "art_piece_photos_sms"
    config.add_index_field 'medium_ss', :label => 'Medium'
    config.add_index_field 'size_ss', :label => 'Size'
    config.add_index_field 'creation_date_ss', :label => 'Created On'
    config.add_index_field 'artists_sms', :label => 'Artists'
    config.add_facet_field 'artists_sms', :label => 'Artists'
    config.add_facet_field 'building_ss', :label => 'Buildings'
    config.add_facet_field 'collections_sms', :label => 'Collections'
    config.add_facet_field 'status_sms', :label => 'Status'
    config.add_facet_field 'displayed_bs', :label => 'Displayed'
    config.add_search_field 'all-fields', :label => 'All Fields'
    config.add_show_field 'medium_ss', :label => 'Medium'
    config.add_show_field 'size_ss', :label => 'Size'
    config.add_show_field 'legal_info_ss', :label => 'Legal Info'
    config.add_show_field 'creation_date_ss', :label => 'Created On'
    config.add_show_field 'contact_info_ss', :label => 'Contact Info'
    config.add_show_field 'artists_sms', :label => 'Artists'
    config.add_show_field 'building_ss', :label => 'Building'
    config.add_show_field 'collections_sms', :label => 'Collections'
    config.add_show_field 'description_ss', :label => 'Description'

    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
    config.add_facet_fields_to_solr_request!
  end

  private

  def exclude_displayed_facet(solr_params, user_params)
    solr_params["facet.field"] -= ["displayed_bs"] unless current_or_guest_user.admin?
  end

  def exclude_not_displayed_items(solr_params, user_params)
    unless current_or_guest_user.admin?
      solr_params[:fq] ||= []
      solr_params[:fq] << "-displayed_bs:false"
    end
  end

end 
