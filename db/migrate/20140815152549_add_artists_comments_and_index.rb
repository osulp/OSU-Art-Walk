class AddArtistsCommentsAndIndex < ActiveRecord::Migration
  def change
    add_column :art_pieces, :artist_comments, :text
    add_index :art_pieces, :artist_comments
  end
end
