require 'csv'

module ArtWalk
  class ArtistImporter
    def self.call(file)
      new(file).import!
    end

    attr_accessor :file

    def initialize(file)
      @file = file
    end

    def import!
      stub_solr
      Artist.transaction do
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
      ArtistRowCreator.call(row)
    end
  end

  class ArtistRowCreator
    def self.call(row)
      new(row).import!
    end

    attr_accessor :row

    def initialize(row)
      @row = row
    end

    def import!
      assign_artist_attributes
      artist.tap(&:save!)
    end

    private

    def artist
      @artist ||= Artist.new
    end

    def assign_artist_attributes
      row.each do |header, value|
        header = header.gsub(' ','_').gsub(/[^A-z_]/,'').underscore
        translate_field(header, value) if translates_field?(header)
        send(:"assign_#{header}", value) if respond_to? :"assign_#{header}", true
      end
    end

    def translates_field?(header)
      field_mapping.include?(header)
    end

    def translate_field(header, value)
      translated_field = field_mapping[header]
      artist.send(:"#{translated_field}=", value)
    end

    def assign_artist_name(value)
      @artist = Artist.find_or_initialize_by(:name => value)
      @artist.save
    end

    def field_mapping
      {
        "born" => "birthdate",
        "died" => "deathdate",
        "artist_website" => "website",
        "bio" => "bio",
        "osu_faculty_past_or_present" => "faculty",
        "osu_student_past_or_present" => "student"
      }
    end
  end
end