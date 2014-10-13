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
  has_many :media, :through => :art_piece_media
  has_many :art_piece_media

  # Series
  has_many :series, :through => :art_piece_series
  has_many :art_piece_series

  #Delegations
  delegate :name, :coords, :to => :building, :prefix => true, :allow_nil => true
  delegate :collection_url, :to => :collections, :prefix => true, :allow_nil => true
  delegate :location, :position_num, :to => :art_piece_building, :prefix => true, :allow_nil => true

  accepts_nested_attributes_for :art_piece_photos, :art_piece_building, :allow_destroy => true

  def status
    status = []
    status << I18n.t('art_piece.faculty_string') if by_faculty?
    status << I18n.t('art_piece.student_string') if by_student?
    status
  end

  def display_status
    display = ""
    display = I18n.t('art_piece.on_display_string') if displayed?
    display = I18n.t('art_piece.not_on_display_string') if !displayed?
    display
  end

  def coords
    return nil if lat.blank? || long.blank?
    [title, lat, long].join("-|-")
  end
  
  private

  def by_faculty?
    artists.find{|x| x.faculty?}.present?
  end

  def by_student?
    artists.find{|x| x.student?}.present?
  end

end
