module ArtWalk
  module Catalog
    module FacetConfiguration
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_facet_field 'artists_sms', :label => 'Artists'
          config.add_facet_field 'medium_ss', :label => 'Medium'
          config.add_facet_field 'building_ss', :label => 'Buildings'
          config.add_facet_field 'collections_sms', :label => 'Collections'
          config.add_facet_field 'status_sms', :label => 'Status'
          config.add_facet_field 'displayed_bs', :label => 'Displayed'
          config.add_search_field 'all-fields', :label => 'All Fields'
        end
      end
    end
  end
end