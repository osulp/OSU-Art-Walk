class CreateBuilding < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.text :description
      t.float :lat
      t.float :long
    end
  end
end
