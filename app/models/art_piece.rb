class ArtPiece < ActiveRecord::Base
  include SunspotModel
  validates :title, :presence => true 


  #Art Piece Building associations
  has_one :building, :through => :art_piece_building
  has_one :art_piece_building

  #Art Piece Artists associations
  has_many :artists, :through => :art_piece_artists
  has_many :art_piece_artists

  #Art Piece Collections associations
  has_many :collections, :through => :art_piece_collections
  has_many :art_piece_collections

  #Art Piece Photo associations
  has_many :art_piece_photos
  accepts_nested_attributes_for :art_piece_photos, :allow_destroy => true


  #indexing
  searchable :auto_index => true, :include => [:building, :artists, :collections, :art_piece_photos] do
    # Searchable Text
    text :title

    # Facets
    string :coords, :stored => true, :multiple => true do
      building.try(:coords)
    end
    string :building, :stored => true do
      building.try(:name)
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
    string :title, :stored => true
    string :medium, :stored => true
    string :size, :stored => true
    string :creation_date, :stored => true
    string :legal_info, :stored => true
    string :contact_info, :stored => true
    string :description, :stored => true
    boolean :displayed, :stored => true

  end

  def status
    status = []
    status << I18n.t('art_piece.faculty_string') if by_faculty?
    status << I18n.t('art_piece.student_string') if by_student?
    status
  end
  
  private

  def by_faculty?
    artists.find{|x| x.faculty?}.present?
  end

  def by_student?
    artists.find{|x| x.student?}.present?
  end
end
