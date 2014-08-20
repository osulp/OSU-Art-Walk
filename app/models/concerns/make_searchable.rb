module MakeSearchable
  extend ActiveSupport::Concern

  included do
      #indexing
    searchable :auto_index => true, :include => [:building, :artists, :collections, :series, :art_piece_photos, :media] do
      # Searchable Text
      text "title"
      text :artists do
        artists.map(&:name)
      end

      text :building_name

      text :collections do
        collections.map(&:name)
      end
      # Facets
      string :coords, :stored => true, :multiple => true do
        coords || building_coords
      end
      string :building, :stored => true do
        building_name
      end
      string :media, :stored => true, :multiple => true do
        media.map(&:medium)
      end
      string :featured_artists, :stored => true, :multiple => true do
        artists.map {|artist| artist.featured_artists}.compact
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
      string :series, :stored => true, :multiple => true do
        series.map(&:name)
      end
      string :status, :stored => true, :multiple => true do
        self.status
      end
      string :art_piece_photos, :stored => true, :multiple => true do
        art_piece_photos.map(&:photo)
      end
      string :art_piece_thumbs, :stored => true, :multiple => true do
        art_piece_photos.map {|photo| photo.photo_url(:thumb)}
      end
      # Displayed Text
      ArtPiece.displayed_texts.each do |text|
        string text, :stored => true
      end
      boolean :displayed, :stored => true
      boolean :private, :stored => true
      boolean :percent_for_art, :stored => true
      integer :art_piece_building_position_num, :stored => true
    end
  end

  module ClassMethods
    def displayed_texts
      [:title, :description, :artist_comments, :size, :creation_date, :legal_info, :contact_info, :art_piece_building_location, :number]
    end
  end
end
