module ArtWalk
  module Catalog
    module ShowConfiguration
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_show_field 'media_sms', :label => 'Medium'
          config.add_show_field 'description_ss', :label => 'Description'
          config.add_show_field 'building_ss', :label => 'Building'
          config.add_show_field 'art_piece_building_location_ss', :label => 'Location'
          config.add_show_field 'creation_date_ss', :label => 'Created On'
          config.add_show_field 'collections_sms', :label => 'Collections'
          config.add_show_field 'series_sms', :label => 'Series'
          config.add_show_field 'number_ss', :label => 'Plaque Number'
          config.add_show_field 'size_ss', :label => 'Size'
          config.add_show_field 'contact_info_ss', :label => 'Contact Info', :if => :private_document?
          config.add_show_field 'artist_comments_ss', :label => 'Artist Comments'
          config.add_show_field 'legal_info_ss', :label => 'Legal Info'
        end
      end
    end
  end
end
