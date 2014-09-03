module ArtWalk
  class PhotoImporter
    def self.call(path_name)
      new(path_name).import!
    end
    def initialize(path_name)
      Dir.chdir(path_name)
      @dir = Dir.glob("*.jpg")
    end
    def import!
      stub_solr
      model.transaction do
        import_photo!(@dir)
      end
      unstub_solr
      model.reindex
    end
    def model
      ArtPiecePhoto
    end

    private
    def stub_solr
      @old_solr = Sunspot.session
      Sunspot.session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)
    end
    def unstub_solr
      Sunspot.session = @old_solr
    end
    def import_photo!(path_name)
      self.class::RowCreator.call(path_name)
    end
    class RowCreator
      def self.call(path_name)
        new(path_name).import!
      end
      attr_accessor :path_name
      def initialize(path_name)
        @path_name = path_name
      end
      def import!
        assign_photos
        resource.tap(&:save!)
      end
      
      protected
      def model
        ArtPiecePhoto
      end
      def resource
        @resource ||= model.new
      end
      def assign_photos
        @path_name.each do |filename|
          @name = filename.split("~")
          @art_piece = Artist.find_or_initialize_by(:name => @name.at(0)).art_pieces.find_or_initialize_by(:title => @name.at(1))
          @art_piece.art_piece_photos.find_or_initialize_by(:photo => File.new(Rails.root.join("tmp", "photos", filename))).save
        end
      end
    end
  end
end
