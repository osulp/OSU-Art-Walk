module ArtWalk
  class ArtPieceNotFoundException < StandardError; end;
  class PhotoImporter < GenericImporter

    def initialize(path_name)
      @dir = Dir.glob(Pathname.new(path_name).join("*.*")).select{|x| x.split(".").last.downcase == "jpg"}
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
      path_name.sort.each do |pathname|
        begin
          self.class::RowCreator.call(pathname)
        rescue ArtPieceNotFoundException => e
          f = File.open('art_walk_importer_errors.txt', 'a') { |file| file.write("Error raised: #{e.message} \n\n") }
        end
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

      def artists
        artists = split_name[0].strip.split(" and").map(&:strip)
        @artists ||= artists.map{|artist| Artist.find_or_initialize_by(:name => artist)}
      end

      def art_piece
        @art_piece ||= begin
                         #DEBUG STATEMENT FOR CHECKING WHICH PHOTOS ARE NOT BEING IMPORTED PROPERLY
                         raise ArtPieceNotFoundException.new("Art Piece '#{filename}' not found.\n Please make sure the art piece following naming convention (artpiece~artist~building~number)\n") if split_name[1].nil?
                         a = artists.first.art_pieces.where('title LIKE ?', split_name[1].gsub('_', '%').gsub('-', '%')).first
                         #DEBUG STATEMENT FOR CHECKING WHICH PHOTOS ARE NOT BEING IMPORTED PROPERLY
                         raise ArtPieceNotFoundException.new("Art Piece '#{filename}' not found. \n Please make sure the art piece is spelled correctly in the google drive and try again\n") if a.nil?
                         a.artists |= artists
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
