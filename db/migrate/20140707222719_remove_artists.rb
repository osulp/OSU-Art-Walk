class RemoveArtists < ActiveRecord::Migration
  def change
    drop_table :artists do |t|
      t.string   :Name
      t.text     :bio
      t.string   :website
      t.string   :birthdate
      t.string   :deathdate
      
      t.timestamps
    end
  end
end
