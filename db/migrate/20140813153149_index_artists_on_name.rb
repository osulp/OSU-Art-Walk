class IndexArtistsOnName < ActiveRecord::Migration
  def change
    add_index :artists, [:name], name:'index_artists_on_name'
  end
end
