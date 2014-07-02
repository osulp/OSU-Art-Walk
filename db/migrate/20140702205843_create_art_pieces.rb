class CreateArtPieces < ActiveRecord::Migration
  def change
    create_table :art_pieces do |t|
      t.string :title
      t.string :medium
      t.string :creation_date
      t.string :size
      t.text :legal_info
      t.boolean :is_temporary
      t.datetime :temporary_until
      t.boolean :private
      t.string :contact_info
      t.text :description
      t.boolean :on_campus

      t.timestamps
    end
  end
end
