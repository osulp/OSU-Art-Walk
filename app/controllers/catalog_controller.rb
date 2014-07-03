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
    config.add_index_field 'title_texts', :label => 'Title:'
    config.add_facet_field 'title_texts', :label => 'Title:'
    config.add_search_field 'all-fields', :label => "All Fields"
    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
  end

end 
