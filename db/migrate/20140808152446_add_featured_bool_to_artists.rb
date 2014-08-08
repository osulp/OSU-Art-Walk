class AddFeaturedBoolToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :featured, :boolean, :default => false
  end
end
