class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :medium
      t.references :art_pieces, index: true
    end
  end
end
