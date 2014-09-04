module ArtWalk
  class PhotoImporter < GenericImporter

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

    private

    def import_photo!(path_name)
      path_name.each do |pathname|
        self.class::RowCreator.call(pathname)
      end
    end

    class RowCreator < GenericImporter::RowCreator
      def self.call(path_name)
        new(path_name).import!
      end

      attr_accessor :path_name, :filename

      def initialize(path_name)
        @path_name = path_name
        @filename = Pathname.new(path_name).basename.to_s
      end

      def import!
        assign_photos
      end

      protected

      def model
        ArtPiecePhoto
      end

      def split_name
        filename.split("~")
      end

      def artist
        @artist ||= Artist.find_or_create_by(:name => split_name[0].strip)
      end

      def art_piece
        @art_piece ||= begin
                         a = artist.art_pieces.find_or_initialize_by(:title => split_name[1])
                         a.artists |= [artist]
                         a.save
                         a
                       end
      end

      def assign_photos
        file = File.open(path_name)
        sanitized_file = CarrierWave::SanitizedFile.new(file)
        art_piece_photo = ArtPiecePhoto.where(:art_piece => art_piece, :photo => sanitized_file.filename).first
        art_piece_photo ||= ArtPiecePhoto.new(:art_piece => art_piece)
        art_piece_photo.photo = file unless art_piece_photo.persisted?
        art_piece_photo.art_piece ||= art_piece
        art_piece_photo.save
      end
    end
  end
end
