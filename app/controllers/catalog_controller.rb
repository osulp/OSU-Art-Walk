# -*- encoding : utf-8 -*-
#
class CatalogController < ApplicationController  

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => "/select",
      :rows => 10
    }
    config.index.title_field = "title_ss"
    config.add_index_field 'title_ss', :label => 'Title'
    config.add_facet_field 'building_ss', :label => 'Buildings'
    config.add_facet_field 'artists_sms', :label => 'Artists'
    config.add_search_field 'all-fields', :label => "All Fields"
    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
    config.add_facet_fields_to_solr_request!
  end

end 
