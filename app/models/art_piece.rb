class ArtPiece < ActiveRecord::Base
  include SunspotAutoIndex
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
    string :collections, :stored => true, :multiple => true do
      collections.map(&:name)
    end

    string :status, :stored => true, :multiple => true

    # Displayed Text
    string :title, :stored => true
  end

  def status
    status = []
    status << t('art_piece.faculty_string') if faculty_piece?
    status << t('art_piece.student_piece') if student_piece?
  end

  private

  def faculty_string
    "Currently A Faculty Member" if current_faculty?
    "Not Currently A Faculty Member"
  end

  def student_string
    "Currently A Student" if current_student?
    "Not Currently A Student"
  end
end
