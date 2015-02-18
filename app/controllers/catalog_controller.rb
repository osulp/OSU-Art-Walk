# -*- encoding : utf-8 -*-
#

class CatalogController < ApplicationController

  include Blacklight::Catalog
  include ArtWalk::Catalog::IndexConfiguration
  include ArtWalk::Catalog::FacetConfiguration
  include ArtWalk::Catalog::ShowConfiguration
  include ArtWalk::Catalog::MapConfiguration
  include ArtWalk::Catalog::SearchConfiguration

  rescue_from ArtWalk::Exceptions::AccessDenied, :with => :no_permissions

  before_filter :load_map_results, :only => :index

  #filter out not-diplayed art pieces
  self.solr_search_params_logic += [:exclude_not_displayed_items]
  self.solr_search_params_logic += [:require_coordinates]

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

  def show
    super
    @map_results = [@document]
  end

  def track
    search_session['counter'] = params[:counter]
    search_session['per_page'] = params[:per_page]

    path = if params[:redirect] and (params[:redirect].starts_with?("/") or params[:redirect] =~ URI::regexp)
             params[:redirect]
           else
             { action: 'show' }
           end
    redirect_to path, :status => 303
  end

  protected

  def cleaned_params
    params_copy = params.reject { |k,v| blacklisted_search_session_params.include?(k.to_sym) or v.blank? }

    params_copy.reject { |k,v| [:action, :controller].include? k.to_sym }
  end
  helper_method :cleaned_params


  private

  def load_map_results
    @map_results = get_search_results(params.merge(:map_view => true), {:start => 0, :rows => 10000, :sort => "art_piece_building_position_num_is asc"}).first.docs unless params[:controller] == "bookmarks"
  end

  def exclude_not_displayed_items(solr_params, user_params)
    unless current_or_guest_user.admin?
      solr_params[:fq] ||= []
      solr_params[:fq] << "-displayed_bs:false"
    end
  end

  def require_coordinates(solr_params, user_params)
    return unless user_params[:map_view]
    solr_params[:fq] ||= []
    solr_params[:fq] << "coords_sms:['' TO *]"
  end

  def check_admin(document)
    unless current_or_guest_user.admin?
      raise ArtWalk::Exceptions::AccessDenied unless document['displayed_bs']
    end
  end

  def get_solr_response_for_doc_id(*args)
    solr_response, document = super
    check_admin(document)
    return [solr_response, document]
  end

  def no_permissions
    flash[:error] = I18n.t('permission_error.error_string')
    redirect_to root_path
  end

end 
