module ArtWalk
  module Catalog
    module FacetConfiguration
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_facet_field 'featured_artists_sms', :label => 'Featured Artists', :collapse => false
          config.add_facet_field 'artists_sms', :label => 'Artists'
          config.add_facet_field 'media_sms', :label => 'Media'
          config.add_facet_field 'building_ss', :label => 'Buildings'
          config.add_facet_field 'collections_sms', :label => 'Collections'
          config.add_facet_field 'series_sms', :label => 'Series'
          config.add_facet_field 'status_sms', :label => 'Status'
          config.add_facet_field 'displayed_bs', :label => 'Displayed'
          config.add_search_field 'all-fields', :label => 'All Fields'
        end
      end
    end
  end
end
