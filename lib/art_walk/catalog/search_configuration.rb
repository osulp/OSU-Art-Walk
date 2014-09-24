module ArtWalk
  module Catalog
    module SearchConfiguration
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_search_field('artists') do |field|
            field.solr_parameters = { :qf => "artists_text" }
          end
          config.add_search_field('titles') do |field|
            field.solr_parameters = { :qf => "title_text" }
          end
          config.add_search_field('buildings') do |field|
            field.solr_parameters = { :qf => "buildings_text" }
          end
          config.add_search_field('medium') do |field|
            field.solr_parameters = { :qf => "media_text" }
          end
          config.add_search_field('collections') do |field|
            field.solr_parameters = { :qf => "collections_text" }
          end
          config.add_search_field('series') do |field|
            field.solr_parameters = { :qf => "series_text" }
          end
        end
      end
    end
  end
end
