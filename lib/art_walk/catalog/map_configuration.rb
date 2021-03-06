module ArtWalk
  module Catalog
    module MapConfiguration
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.view.maps.type = "placename_coord" # also accepts 'placename_coord'/'bbox' to use the placename coordinate type
          config.view.maps.bbox_field = "place_bbox"
          config.view.maps.placename_coord_field = "coords_sms"
          config.view.maps.tileurl = "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          config.view.maps.attribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
          config.view.maps.placename_coord_delimiter = '-|-'
          config.view.maps.minzoom = 16
          config.view.maps.maxzoom = 17
          config.view.maps.default = true
        end
      end
    end
  end
end