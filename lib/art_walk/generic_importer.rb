module ArtWalk
  class GenericImporter
    def self.call(file)
      new(file).import!
    end

    attr_accessor :file

    def initialize(file)
      @file = file
    end

    def model
      ArtPiece
    end

    def import!
      stub_solr
      model.transaction do
        rows.each do |row|
          import_row!(row)
        end
      end
      unstub_solr
      model.reindex
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
      self.class::RowCreator.call(row)
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
        assign_attributes
        resource.tap(&:save!)
      end

      protected

      def model
        ArtPiece
      end

      def resource
        @resource ||= model.new
      end

      def assign_attributes
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
        resource.send(:"#{translated_field}=", value)
      end

      def field_mapping
        {}
      end

    end

  end
end
