class ArtPiece < ActiveRecord::Base
  include SunspotModel
  include MakeSearchable

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

  #Medium association
  belongs_to :medium

  delegate :name, :coords, :to => :building, :prefix => true, :allow_nil => true
  delegate :location, :to => :art_piece_building, :prefix => true, :allow_nil => true
  delegate :medium, :to => :medium, :prefix => :art, :allow_nil => true

  accepts_nested_attributes_for :art_piece_photos, :art_piece_building, :allow_destroy => true

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
