class ArtPiece < ActiveRecord::Base
  include SunspotModel
  validates :title, :presence => true 

  has_one :building, :through => :art_piece_building
  has_one :art_piece_building

  has_many :artists, :through => :art_piece_artists
  has_many :art_piece_artists

  has_many :collections, :through => :art_piece_collections
  has_many :art_piece_collections

  searchable :auto_index => true, :include => [:building, :artists] do
    # Searchable Text
    text :title

    # Facets
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

    # Displayed Text
    string :title, :stored => true
    string :medium, :stored => true
    string :creation_date, :stored => true

  end

  mount_uploader :photo, PhotoUploader

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
