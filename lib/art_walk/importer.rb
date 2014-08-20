require 'csv'

module ArtWalk
  class Importer
    def self.call(file)
      new(file).import!
    end

    attr_accessor :file

    def initialize(file)
      @file = file
    end

    def import!
      stub_solr
      ArtPiece.transaction do
        rows.each do |row|
          import_row!(row)
        end
      end
      unstub_solr
      ArtPiece.reindex
    end

    def rows
      @rows ||= CSV.open(file, :headers => true)
    end

    private

    def stub_solr
      @old_solr = Sunspot.session
      Sunspot.session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)      
    end

    def unstub_solr
      Sunspot.session = @old_solr
    end

    def import_row!(row)
      RowCreator.call(row)
    end
  end

  class RowCreator
    def self.call(row)
      new(row).import!
    end

    attr_accessor :row

    def initialize(row)
      @row = row
    end

    def import!
      assign_art_piece_attributes
      art_piece.tap(&:save!)
    end

    private

    def art_piece
      @art_piece ||= ArtPiece.new
    end

    def assign_art_piece_attributes
      row.each do |header, value|
        header = header.gsub(' ','_').gsub(/[^A-z_]/,'').underscore
        translate_field(header, value) if translates_field?(header)
        send(:"assign_#{header}", value) if respond_to? :"assign_#{header}", true
      end
    end

    def assign_artist_name(value)
      new_val = value.split(/[&;]/)
      new_val.each do |val|
        new_artist = Artist.find_or_initialize_by(:name => val)
        new_artist.save
        art_piece.artists = [new_artist]
      end
      art_piece.save
    end

    def assign_building(value)
      new_building = Building.find_or_initialize_by(:name => value)
      new_building.save
      art_piece.building = new_building
      art_piece.save
    end

    def assign_series(value)
      new_val = value.to_s.split(/[,]/)
      art_piece.series = []
      new_val.each do |val|
        new_series = Series.find_or_initialize_by(:name => val.strip)
        art_piece.series << new_series
      end
      art_piece.save
    end

    def assign_medium(value)
      new_val = value.to_s.gsub(" and ", ",").split(/[;,]/).delete_if(&:blank?)
      art_piece.media = []
      new_val.each do |val|
        new_media = Medium.find_or_initialize_by(:medium => val.strip)
        art_piece.media << new_media
      end
      art_piece.save
    end

    def assign_accessibility(value)
      if value == "Public"
        art_piece.private = false
      else
        art_piece.private = true
      end
      art_piece.contact_info = value
      art_piece.save
    end

    def assign_lost_moving_to_be_hidden(value)
      if value == "FALSE"
        art_piece.displayed = true
      else
        art_piece.displayed = false
      end
      art_piece.save
    end

    def assign_location(value)
      art_piece.art_piece_building.location = value
      art_piece.save
    end

    def assign_number_for_website(value)
      art_piece.art_piece_building.position_num = value
      art_piece.save
    end

    def translates_field?(header)
      field_mapping.include?(header)
    end

    def translate_field(header, value)
      translated_field = field_mapping[header]
      art_piece.send(:"#{translated_field}=", value)
    end

    def assign_work_title(value)
      if value.blank?
        art_piece.title = "untitled"
      else
        art_piece.title = value
      end
      art_piece.save
    end

    def field_mapping
      {
        "additional_information_including_all_data_collected_from_plaques_that_accompany_the_pieces" => "description",
        "year" => "creation_date",
        "dimensions" => "size",
        "artist_notes" => "artist_comments",
        "lost_moving_to_be_hidden" => "displayed",
        "number_on_plaque_valley_nw_art_exhibit_only" => "number"
      }
    end
  end
end