class CreateMediums < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :type
      t.references :art_piece, index: true

      t.timestamps
    end
  end
end
