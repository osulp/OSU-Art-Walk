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
  delegate :name, :coords, :description, :lat, :long, :to => :building, :prefix => true, :allow_nil => true
  delegate :collection_url, :to => :collections, :prefix => true, :allow_nil => true
  delegate :location, :position_num, :floor, :to => :art_piece_building, :prefix => true, :allow_nil => true


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

  def collection_urls
    collections.map(&:collection_url)
  end
  
  private

  def by_faculty?
    artists.find{|x| x.faculty?}.present?
  end

  def by_student?
    artists.find{|x| x.student?}.present?
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Art Piece Name", "Created on", "Size", "Legal Info", "Contact Info", "Description", 
              "Displayed", "Private", "Number", "Artist Comments", "Art Piece Latitude", 
              "Art Piece Longitude", "Photo Credit", "Artist Name", "Artist Bio", "Artist Birthdate",
              "Artist Deathdate", "Artist Is Student", "Artist Is Faculty", "Artist Is Featured", "Building Name", 
              "Building Description", "Building Latitude", "Building Longitude", "Floor", 
              "Location in Building", "Position in Building", "Collections", "Media", "Series", 'Art Piece Photo Credit']
      all.each do |art|
        csv << [art.title, art.creation_date, art.size, art.legal_info, art.contact_info, 
                art.description, art.displayed, art.private, art.number, art.artist_comments,
                art.lat, art.long, art.global_photo_credit, art.artists.map{|artist| artist.name}.compact.join("; "), 
                art.artists.map{|artist| artist.bio}.compact.join(", "), art.artists.map{|artist| artist.birthdate}.compact.join(", "),
                art.artists.map{|artist| artist.deathdate}.compact.join(", "), art.artists.map{|artist| artist.student}.compact.join(", "),
                art.artists.map{|artist| artist.faculty}.compact.join(", "), art.artists.map{|artist| artist.featured}.compact.join(", "),
                art.building_name, art.building_description, art.building_lat, art.building_long,
                art.art_piece_building_floor, art.art_piece_building_location, art.art_piece_building_position_num, 
                art.collections.map{|collection| collection.name}.compact.join(", "), art.media.map{|media| media.medium}.compact.join(", "),
                art.series.map{|series| series.name}.compact.join(", "), art.art_piece_photos.map{|photo| photo.photo_credit}.compact.join(", ")]
      end
    end
  end
end
