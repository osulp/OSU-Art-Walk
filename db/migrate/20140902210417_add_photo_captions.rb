class AddPhotoCaptions < ActiveRecord::Migration
  def change
    add_column :art_piece_photos, :photo_credit, :string
  end
end
