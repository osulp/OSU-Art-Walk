module ArtWalk
  module Catalog
    module IndexConfiguration
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.index.title_field = "title_ss"
          config.index.thumbnail_field = "art_piece_photos_sms"
          config.add_index_field 'medium_ss', :label => 'Medium'
          config.add_index_field 'size_ss', :label => 'Size'
          config.add_index_field 'creation_date_ss', :label => 'Created On'
          config.add_index_field 'artists_sms', :label => 'Artists'
          config.add_index_field 'art_piece_building_location_ss', :label => 'Location'
        end
      end
    end
  end
end
