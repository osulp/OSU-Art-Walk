module ArtWalk
  module Catalog
    module FacetConfiguration
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_facet_field 'featured_artists_sms', :label => 'Featured Artists', :collapse => false, :limit => 30
          config.add_facet_field 'artists_sms', :label => 'Artists', :limit => 10, :sort => 'index'
          config.add_facet_field 'media_sms', :label => 'Media', :limit => 10
          config.add_facet_field 'building_ss', :label => 'Buildings', :limit => 10
          config.add_facet_field 'collections_sms', :label => 'Collections', :limit => 10
          config.add_facet_field 'status_sms', :label => 'Status', :limit => 10
          config.add_facet_field 'display_ss', :label => 'Displayed', :if => :admin?
          config.add_search_field 'all-fields', :label => 'All Fields'
        end
      end
    end
  end
end
