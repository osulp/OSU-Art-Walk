class AddArtistsCommentsAndIndex < ActiveRecord::Migration
  def change
    add_column :art_pieces, :artist_comments, :text
  end
end
