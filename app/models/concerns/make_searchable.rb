module MakeSearchable
  extend ActiveSupport::Concern

  included do
      #indexing
    searchable :auto_index => true, :include => [:building, :artists, :collections, :art_piece_photos, :medium] do
      # Searchable Text
      text "title"
      text :artists do
        artists.map(&:name)
      end
      text :art_medium

      text :building_name

      text :collections do
        collections.map(&:name)
      end
      # Facets
      string :coords, :stored => true, :multiple => true do
        building_coords
      end
      string :building, :stored => true do
        building_name
      end
      string :medium, :stored => true do
        art_medium
      end
      string :artists, :stored => true, :multiple => true do
        artists.map(&:name)
      end
      string :artist_bio, :stored => true, :multiple => true do
        artists.map(&:bio)
      end
      string :collections, :stored => true, :multiple => true do
        collections.map(&:name)
      end
      string :status, :stored => true, :multiple => true do
        self.status
      end
      string :art_piece_photos, :stored => true, :multiple => true do
        art_piece_photos.map(&:photo)
      end
      # Displayed Text
      ArtPiece.displayed_texts.each do |text|
        string text, :stored => true
      end
      boolean :displayed, :stored => true
    end
  end

  module ClassMethods
    def displayed_texts
      [:title, :description, :size, :creation_date, :legal_info, :contact_info, :art_piece_building_location]
    end
  end
end
