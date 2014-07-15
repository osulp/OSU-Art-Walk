class FixupTables < ActiveRecord::Migration
  def change
    remove_column :collections, :art_pieces_id, :integer
    remove_column :artists, :art_piece_id, :integer
    remove_column :art_pieces, :collections_id, :integer
    remove_column :art_pieces, :artist_id, :integer

    change_table :art_piece_collections do |t|
      t.rename :art_pieces_id, :art_piece_id
    end

    change_table :art_piece_collections do |t|
      t.rename :collections_id, :collection_id
    end
  end
end
