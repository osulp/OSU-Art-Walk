# -*- encoding : utf-8 -*-
#

class CatalogController < ApplicationController

  include Blacklight::Catalog
  include ArtWalk::Catalog::IndexConfiguration
  include ArtWalk::Catalog::FacetConfiguration
  include ArtWalk::Catalog::ShowConfiguration
  include ArtWalk::Catalog::MapConfiguration

  before_filter :load_map_results, :only => :index

  #filter out not-diplayed art pieces
  self.solr_search_params_logic += [:exclude_not_displayed_items]
  self.solr_search_params_logic += [:exclude_displayed_facet]

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => "search",
      :rows => 10
    }

    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
    config.add_facet_fields_to_solr_request!
  end

  private

  def load_map_results
    @map_results = get_search_results(params, {:rows => 10000, :fq => "coords_sms:['' TO *]"}).first
  end

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
