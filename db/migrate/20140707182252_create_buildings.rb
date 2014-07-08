class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.text :description
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
